extends Node2D

func update_screen() -> void:
	for i in $Keys.get_children():
		if is_instance_of(i, Key_button):
			var instance: Key_button = i
			var key_id = instance.id_name
			#instance.pressed = Global.keys_state.get(key_id).pressed
			#instance.unlocked = Global.keys_state.get(key_id).state
			#instance.multiplicator = Global.keys_state.get(key_id).multiplicator
			# Tools.showdebugtext("sdsdf", 1231)
	
	$UI/Score_j1.text = "SCORE: " + str(Global.score_j1)
	$UI/Score_j2.text = "SCORE: " + str(Global.score_j2)

func _process(delta: float) -> void:
	update_screen()
