extends Node
signal power_chosen

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("1") and Global.powers_available_j1:
		unlock_keys(1)
		power_chosen.emit(1)
	if Input.is_action_just_pressed("2") and Global.powers_available_j1:
		boost_keys(1)
		power_chosen.emit(1)
	if Input.is_action_just_pressed("3") and Global.powers_available_j1:
		boost_all_keys(1)
		power_chosen.emit(1)
	if Input.is_action_just_pressed("6") and Global.powers_available_j2:
		unlock_keys(2)
		power_chosen.emit(2)
	if Input.is_action_just_pressed("7") and Global.powers_available_j2:
		boost_keys(2)
		power_chosen.emit(2)
	if Input.is_action_just_pressed("8") and Global.powers_available_j2:
		boost_all_keys(2)
		power_chosen.emit(2)

func get_player_keys(player_num) -> Array:
	var hmap_keys = Global.keys_state.keys()
	var player_hmap_keys_array = hmap_keys.filter(func(id_name): return Global.keys_state.get(id_name).player == player_num)
	
	return player_hmap_keys_array

func unlock_keys(player_num):
	Tools.showdebugtext("last_power", "unlock")
	
	# GET UNLOCKED KEYS OF PLAYER
	var player_keys = get_player_keys(player_num)
	var locked_keys = player_keys.filter(func(id_name): return !Global.keys_state.get(id_name).state)

	# CHOOSE X RANDOM
	var count = 3
	var pool = locked_keys.duplicate()
	pool.shuffle()
	var random_locked_unhmap_keys = pool.slice(0, count)
	
	# ENABLE THESE KEYS
	var property = "state"
	for hmap_key in random_locked_unhmap_keys:
		Global.keys_state.get(hmap_key).set(property, true)

func boost_keys(player_num):
	Tools.showdebugtext("last_power", "boost")
	
	# GET LOCKED KEYS OF PLAYER
	var count = 1
	var player_keys = get_player_keys(player_num)
	var unlocked_keys = player_keys.filter(func(id_name): return Global.keys_state.get(id_name).state)

	# CHOOSE X RANDOM
	var pool = unlocked_keys.duplicate()
	pool.shuffle()
	var random_unlocked_unhmap_keys = pool.slice(0, count)
	
	# ENABLE THESE KEYS
	var property = "multiplicator"
	for hmap_key in random_unlocked_unhmap_keys:
		var current_multiplicator = Global.keys_state.get(hmap_key).get(property)
		var step = 10
		Global.keys_state.get(hmap_key).set(property, current_multiplicator + step)

func boost_all_keys(player_num):
	Tools.showdebugtext("last_power", "allkeys11111")
	
	# GET LOCKED KEYS OF PLAYER
	var player_keys = get_player_keys(player_num)
	var unlocked_keys = player_keys.filter(func(id_name): return Global.keys_state.get(id_name).state)

	# ENABLE THESE KEYS
	var property = "multiplicator"
	for hmap_key in unlocked_keys:
		var current_multiplicator = Global.keys_state.get(hmap_key).get(property)
		var step = 2
		Global.keys_state.get(hmap_key).set(property, current_multiplicator + step)
