extends Node
signal power_chosen

const UNLOCK_RANDOM_KEYS_COUNT = 2
const BOOST_RANDOM_KEYS_VALUE = 6
const BOOST_RANDOM_KEYS_COUNT = 3
const BOOST_ALL_KEYS_VALUE = 2

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("1") and Global.powers_available_j1:
		unlock_random_keys(1)
		power_chosen.emit(1)
	if Input.is_action_just_pressed("2") and Global.powers_available_j1:
		boost_random_keys(1)
		power_chosen.emit(1)
	if Input.is_action_just_pressed("3") and Global.powers_available_j1:
		boost_all_keys(1)
		power_chosen.emit(1)
	if Input.is_action_just_pressed("6") and Global.powers_available_j2:
		unlock_random_keys(2)
		power_chosen.emit(2)
	if Input.is_action_just_pressed("7") and Global.powers_available_j2:
		boost_random_keys(2)
		power_chosen.emit(2)
	if Input.is_action_just_pressed("8") and Global.powers_available_j2:
		boost_all_keys(2)
		power_chosen.emit(2)

func get_player_keys(player_num) -> Array:
	var hmap_keys = Global.keys_state.keys()
	var player_hmap_keys_array = hmap_keys.filter(func(id_name): return Global.keys_state.get(id_name).player == player_num)
	
	return player_hmap_keys_array

func unlock_random_keys(player_num):
	Tools.showdebugtext("last_power", "unlock")
	
	# GET UNLOCKED KEYS OF PLAYER
	var player_keys = get_player_keys(player_num)
	var locked_keys = player_keys.filter(func(id_name): return !Global.keys_state.get(id_name).state)

	# CHOOSE X RANDOM
	var pool = locked_keys.duplicate()
	pool.shuffle()
	var random_locked_unhmap_keys = pool.slice(0, UNLOCK_RANDOM_KEYS_COUNT)
	
	# ENABLE THESE KEYS
	var property = "state"
	for hmap_key in random_locked_unhmap_keys:
		Global.keys_state.get(hmap_key).set(property, true)

	# DISPLAY TEXT
	# keys XXX enabled
	var displayed_text = "Keys "
	for hmap_key in random_locked_unhmap_keys:
		displayed_text += hmap_key + " "
	displayed_text += "unlocked!"

	if player_num == 1:
		Global.text_j1 = displayed_text
	else:
		Global.text_j2 = displayed_text

func boost_random_keys(player_num):
	Tools.showdebugtext("last_power", "boost")
	
	# GET LOCKED KEYS OF PLAYER
	var player_keys = get_player_keys(player_num)
	var unlocked_keys = player_keys.filter(func(id_name): return Global.keys_state.get(id_name).state)

	# CHOOSE X RANDOM
	var pool = unlocked_keys.duplicate()
	pool.shuffle()
	var random_unlocked_unhmap_keys = pool.slice(0, BOOST_RANDOM_KEYS_COUNT)
	
	# BOOST THESE KEYS
	var property = "multiplicator"
	for hmap_key in random_unlocked_unhmap_keys:
		var current_multiplicator = Global.keys_state.get(hmap_key).get(property)
		Global.keys_state.get(hmap_key).set(property, current_multiplicator + BOOST_RANDOM_KEYS_VALUE)

	# DISPLAY TEXT
	# keys XXX boosted
	var displayed_text = "Keys "
	for hmap_key in random_unlocked_unhmap_keys:
		displayed_text += hmap_key + " "
	displayed_text += "boosted by " + str(BOOST_RANDOM_KEYS_VALUE) + "!"

	if player_num == 1:
		Global.text_j1 = displayed_text
	else:
		Global.text_j2 = displayed_text

func boost_all_keys(player_num):
	Tools.showdebugtext("last_power", "allkeys")
	
	# GET KEYS OF PLAYER
	var player_keys = get_player_keys(player_num)

	# ENABLE THESE KEYS
	var property = "multiplicator"
	for hmap_key in player_keys:
		var current_multiplicator = Global.keys_state.get(hmap_key).get(property)
		Global.keys_state.get(hmap_key).set(property, current_multiplicator + BOOST_ALL_KEYS_VALUE)
	
	
	# DISPLAY TEXT
	# keys XXX boosted
	var displayed_text = "All keys boosted by " + str(BOOST_ALL_KEYS_VALUE) + "!"

	if player_num == 1:
		Global.text_j1 = displayed_text
	else:
		Global.text_j2 = displayed_text
