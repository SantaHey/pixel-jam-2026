extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Q") :
		if Global.keys_state["q"]["state"]==true  :
			Global.score_j1 += 1*Global.keys_state["q"]["multiplicator"]
		Tools.showdebugtext("Q",Global.score_j1)
	
	if Input.is_action_just_pressed("W") :
		if Global.keys_state["w"]["state"]==true  :
			Global.score_j1 += 1*Global.keys_state["w"]["multiplicator"]
		Tools.showdebugtext("W", Global.score_j1)
		
	if Input.is_action_just_pressed("Z") :
		if Global.keys_state["z"]["state"]==true  :
			Global.score_j2 += 1*Global.keys_state["z"]["multiplicator"]
		Tools.showdebugtext("Z", Global.score_j2)
		
	if Input.is_action_just_pressed("U") :
		if Global.keys_state["u"]["state"]==true  :
			Global.score_j2 += 1*Global.keys_state["u"]["multiplicator"]
		Tools.showdebugtext("U", Global.score_j2)             
		
