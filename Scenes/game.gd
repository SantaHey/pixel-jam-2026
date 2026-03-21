extends Node2D

func _ready() -> void:
	print("wow")

func _process(delta: float) -> void:
	
	Tools.showdebugtext("SCORE_J1", Global.score_j1)
	Tools.showdebugtext("SCORE_J2", Global.score_j2)
	
	var added_points_j1 = 0
	var added_points_j2 = 0
	
	if Input.is_action_just_pressed("q") :
		if Global.keys_state["q"]["state"]==true  :
			added_points_j1 += Global.keys_state["q"]["multiplicator"]
		Tools.showdebugtext("q",Global.score_j1)
	
	if Input.is_action_just_pressed("w") :
		if Global.keys_state["w"]["state"]==true  :
			added_points_j1 += Global.keys_state["w"]["multiplicator"]
		Tools.showdebugtext("w", Global.score_j1)
		
	if Input.is_action_just_pressed("z") :
		if Global.keys_state["z"]["state"]==true  :
			added_points_j2 += 1*Global.keys_state["z"]["multiplicator"]
		Tools.showdebugtext("z", Global.score_j2)
		
	if Input.is_action_just_pressed("u") :
		if Global.keys_state["u"]["state"]==true  :
			added_points_j2 += 1*Global.keys_state["u"]["multiplicator"]
		Tools.showdebugtext("u", Global.score_j2)             
	
	var j1_reach_value = Global.floors[Global.current_floor].reach_value
	# SI ON EST EN TRAIN DE PASSER LE FLOOR
	if Global.score_j1 < j1_reach_value and Global.score_j1 + added_points_j1 > j1_reach_value:
		next_floor(1)
	
	var j2_reach_value = Global.floors[Global.current_floor].reach_value
	if Global.score_j2 < j2_reach_value and Global.score_j2 + added_points_j2 > j2_reach_value:
		next_floor(1)

	# ADDED
	Global.score_j1 += added_points_j1
	Global.score_j2 += added_points_j2

func next_floor(player_num):
	Tools.showdebugtext("FLOOR", Global.current_floor)
	Global.current_floor += 1
