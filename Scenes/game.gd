extends Node2D

var score_high = 1000.0

var last_tier_j1 = 0
var last_tier_j2 = 0

func _ready() -> void:
	# ENABLE ALL
	for i in $Keys.get_children():
		var instance = i
		if is_instance_of(instance, Key_button):
			var key_instance: Key_button = instance
			Global.keys_state[key_instance.id_name].set("state", true)
	Tools.debug_enable = true

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
	
	if Global.current_floor_j1 != last_tier_j1:
		var anim: AnimationPlayer = $PalierDroite.get_node("AnimationPlayer")
		print("ohsamère")
	last_tier_j1 = Global.current_floor_j1
		

func _process(delta: float) -> void:
	Tools.showdebugtext("fps", Engine.get_frames_per_second())
	update_screen()
