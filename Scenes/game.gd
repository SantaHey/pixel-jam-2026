extends Node2D

func _ready() -> void:
	# ENABLE ALL
	for i in $Keys.get_children():
		var instance = i
		if is_instance_of(instance, Key_button):
			var key_instance: Key_button = instance
			Global.keys_state[key_instance.id_name].set("state", true)


func _ready() -> void:
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
	
	var j1_score = Global.score_j1
	var j2_score = Global.score_j2
	
	$UI/Score_j1.text = "SCORE: " + str(j1_score)
	$UI/Score_j2.text = "SCORE: " + str(j2_score)
	
	var curr_min_score = Global.floors.get(Global.current_floor)["base_value"]
	var curr_max_score = Global.floors.get(Global.current_floor)["reach_value"]
	
	$UI/ProgressBar_j1.value = ((j1_score - curr_min_score) / (curr_max_score - curr_min_score)) * 100
	

func _process(delta: float) -> void:
	Tools.showdebugtext("fps", Engine.get_frames_per_second())
	update_screen()
