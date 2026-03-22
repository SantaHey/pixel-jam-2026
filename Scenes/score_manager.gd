extends Node

func _process(delta: float) -> void:
	
	#Tools.showdebugtext("SCORE_J1", Global.score_j1)
	#Tools.showdebugtext("SCORE_J2", Global.score_j2)
	#Tools.showdebugtext("FLOOR", Global.current_floor)
	
	var added_points_j1 = 0
	var added_points_j2 = 0
	
	var number = "1234567890"
	
	for key_id_name in Global.keys_state.keys():
		if Input.is_action_just_pressed(key_id_name) and key_id_name not in number:
			if Global.keys_state[key_id_name]["state"]==true :
				Global.keys_state.get(key_id_name).set("pressed", true)
				if Global.keys_state[key_id_name]["player"] == 1:
					# J1
					added_points_j1 += Global.keys_state[key_id_name]["multiplicator"]
				else:
					# J2
					added_points_j2 += Global.keys_state[key_id_name]["multiplicator"]
		
		if Input.is_action_just_released(key_id_name) :
			Global.keys_state.get(key_id_name).set("pressed", false)
	
	# FLOOR LOGIC
	var j1_reach_value = Global.floors[Global.current_floor_j1].reach_value
	# SI ON EST EN TRAIN DE PASSER LE FLOOR
	if Global.score_j1 < j1_reach_value and Global.score_j1 + added_points_j1 >= j1_reach_value:
		next_floor(1)
	
	var j2_reach_value = Global.floors[Global.current_floor_j2].reach_value
	if Global.score_j2 < j2_reach_value and Global.score_j2 + added_points_j2 >= j2_reach_value:
		next_floor(2)

	# ADDED
	Global.score_j1 += added_points_j1
	Global.score_j2 += added_points_j2

func next_floor(player_num):
	if player_num == 1:
		Global.current_floor_j1 += 1
	else:
		Global.current_floor_j2 += 1
