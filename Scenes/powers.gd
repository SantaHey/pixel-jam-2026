extends Node

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		power_upgrade_one_random(1)
		
	# display
	#Tools.showdebugtext("1_q", key("q"))
	#Tools.showdebugtext("1_w", key("w"))
	#Tools.showdebugtext("2_z", key("z"))
	#Tools.showdebugtext("2_u", key("u"))

func power_upgrade_one_random(player_num):
	var keys = Global.keys_state.keys()

	# --- FILTER ---
	var player_keys = keys.filter(func(id_name): return key(id_name).player == player_num)
	var random_key_name = player_keys.pick_random()
	
	print(random_key_name)
	
	Global.keys_state.get(random_key_name).set("multiplicator", key(random_key_name).multiplicator * 1.1)


func power_toggle_one_random(player_num):
	var keys = Global.keys_state.keys()

	# --- FILTER ---
	var player_keys = keys.filter(func(id_name): return key(id_name).player == player_num)
	var random_key_name = player_keys.pick_random()
	
	print(random_key_name)
	
	Global.keys_state.get(random_key_name).set("state", !key(random_key_name).state)

func key(name):
	if Global.keys_state != null:
		return Global.keys_state.get(name)
