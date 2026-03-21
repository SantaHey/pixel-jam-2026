extends Node2D

func _ready() -> void:
	# ENABLE ALL
	for i in $Keys.get_children():
		var instance = i
		if is_instance_of(instance, Key_button):
			var key_instance: Key_button = instance
			Global.keys_state[key_instance.id_name].set("state", true)


func update_screen() -> void:
	for i in $Keys.get_children():
		if is_instance_of(i, Key_button):
			var instance: Key_button = i
			var key_id = instance.id_name
			if Global.keys_state.get(key_id) != null:
				instance.pressed = Global.keys_state.get(key_id).pressed
				instance.unlocked = Global.keys_state.get(key_id).state
				instance.multiplicator = Global.keys_state.get(key_id).multiplicator
				Tools.showdebugtext("sdsdf", 1231)
	
	$UI/Score_j1.text = "SCORE: " + str(Global.score_j1)
	$UI/Score_j2.text = "SCORE: " + str(Global.score_j2)

func _process(delta: float) -> void:
	update_screen()
