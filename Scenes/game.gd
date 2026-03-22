extends Node2D

var score_high = 1000.0

var last_tier_j1 = 0
var last_tier_j2 = 0

func _on_countdown_timeout() -> void:
	$GameTimer.start()
	$CountdownUI.hide()
	
	# Start event timer
	$EventManager/EventTriggerTimer.start()

	# ENABLE ONE KEY BY PLAYER
	# enable random key
	var hmap_keys = Global.keys_state.keys()
	var all_keys_j1 = hmap_keys.filter(func(id_name):
		return Global.keys_state[id_name].player == 1
	)
	var all_keys_j2 = hmap_keys.filter(func(id_name):
		return Global.keys_state[id_name].player == 2
	)

	# one random_key_j1
	var random_key_j1 = all_keys_j1[randi() % all_keys_j1.size()]
	Global.keys_state.get(random_key_j1).set("state", true)

	# one random_key_j2
	var random_key_j2 = all_keys_j2[randi() % all_keys_j2.size()]
	Global.keys_state.get(random_key_j2).set("state", true)


func _ready() -> void:
	Global.init()
	
	# ENABLE ALL
	#for i in $Keys.get_children():
		#var instance = i
		#if is_instance_of(instance, Key_button):
			#var key_instance: Key_button = instance
			#Global.keys_state[key_instance.id_name].set("state", true)
	# Tools.debug_enable = true
	$Countdown.one_shot = true
	$Countdown.start()

func update_screen() -> void:
	for i in $Keys.get_children():
		if is_instance_of(i, Key_button):
			var instance: Key_button = i
			var key_id = instance.id_name
			if Global.keys_state.get(key_id) != null:
				instance.pressed = Global.keys_state.get(key_id).pressed
				instance.unlocked = Global.keys_state.get(key_id).state
				instance.multiplicator = Global.keys_state.get(key_id).multiplicator
				if Global.keys_state[instance.id_name]["player"] == 1:
					instance.chaos_percent = Global.score_j1 / score_high
				else:
					instance.chaos_percent = Global.score_j2 / score_high
			
	var j1_score = Global.score_j1
	var j2_score = Global.score_j2
	
	$UI/Score_j1.text = "SCORE: " + str(int(j1_score))
	$UI/Score_j2.text = "SCORE: " + str(int(j2_score))
	
	var curr_min_score_j1 = Global.floors.get(Global.current_floor_j1)["base_value"]
	var curr_max_score_j1 = Global.floors.get(Global.current_floor_j1)["reach_value"]
	
	$UI/ProgressBar_j1.value = ((j1_score - curr_min_score_j1) / (curr_max_score_j1 - curr_min_score_j1)) * 100
	
	var curr_min_score_j2 = Global.floors.get(Global.current_floor_j2)["base_value"]
	var curr_max_score_j2 = Global.floors.get(Global.current_floor_j2)["reach_value"]
	
	$UI/ProgressBar_j2.value = ((j2_score - curr_min_score_j2) / (curr_max_score_j2 - curr_min_score_j2)) * 100
	
	$UI/Floor_text_j1.text = "TIER: " + str(Global.current_floor_j1)
	$UI/Floor_text_j2.text = "TIER: " + str(Global.current_floor_j2)
	
	# display quest text
	$UI/Quest_j1.text = Global.text_j1.to_upper()
	$UI/Quest_j2.text = Global.text_j2.to_upper()
	
	# display Timer
	var minutes = int(Global.timer / 60)
	var seconds = int(Global.timer % 60)
	$UI/Timer_minutes.text = str(minutes).pad_zeros(2)
	$UI/Timer_seconds.text = str(seconds).pad_zeros(2)
	
	if Global.current_floor_j1 != last_tier_j1:
		var anim: AnimationPlayer = $PalierGauche.get_node("AnimationPlayer")
		anim.play(&"SlideIN")
		Global.powers_available_j1 = true
	last_tier_j1 = Global.current_floor_j1
	
	if Global.current_floor_j2 != last_tier_j2:
		var anim: AnimationPlayer = $PalierDroite.get_node("AnimationPlayer")
		anim.play(&"SlideIN")
		Global.powers_available_j2 = true
	last_tier_j2 = Global.current_floor_j2
	
	$CountdownUI/RichTextLabel.text = str(int($Countdown.time_left + 1))
		

func _process(delta: float) -> void:
	Tools.showdebugtext("fps", Engine.get_frames_per_second())
	Tools.showdebugtext("text_j1", Global.text_j1)
	Tools.showdebugtext("text_j2", Global.text_j2)
	update_screen()
	
	# log texts
	Tools.showdebugtext("text_j1", Global.text_j1)
	Tools.showdebugtext("text_j2", Global. text_j2)


func _on_floor_powers_power_chosen(j:int) -> void:
	print("Chosen on player " + str(j))
	if j == 1:
		var anim: AnimationPlayer = $PalierGauche.get_node("AnimationPlayer")
		Global.powers_available_j1 = false
		anim.play(&"SlideOUT")
	else:
		var anim: AnimationPlayer = $PalierDroite.get_node("AnimationPlayer")
		Global.powers_available_j2 = false
		anim.play(&"SlideOUT")


func _on_game_timer_timeout() -> void:
	Global.timer-=1
	print(Global.timer)
	if Global.timer <= 0 :
		$GameTimer.stop()
		if Global.score_j1 >= Global.score_j2 :
			Global.winner = 1
			get_tree().change_scene_to_file("res://Scenes/Win_screen.tscn")
		else:
			Global.winner = 2
			get_tree().change_scene_to_file("res://Scenes/Win_screen.tscn")
