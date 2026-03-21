extends Node

var bonus = 2
var malus = 0

				   

func choose_event(id,n):
	var choice = randf_range(0.0,1.0)
	print(choice)
	if choice > 0.5 :
		bonus_event(id,n)
	else :
		if id==1:
			malus_event(2,n)
		else :
			malus_event(1,n)

func bonus_event(id,n):
	var keys = select_random_key(id,n)
	for k in keys:
		Global.keys_state[k].multiplicator = bonus

func malus_event(id,n):
	var keys = select_random_key(id,n)
	for k in keys:
		Global.keys_state[k].multiplicator = malus

func get_available_key(id):
	var available_key = []
	for key in Global.keys_state:
			available_key.append(key)
	return available_key


func select_random_key(id,n):
	var bonus_list = []
	var list = get_available_key(id)
	if len(list)<=n:
		return list
	else :
		for i in range(n):
			list.shuffle()
			bonus_list.append(list.pop_front())
		return bonus_list

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("test"):
		Tools.showdebugtext("space", "press")
		choose_event(1,2)


func _on_timer_timeout() -> void:
	choose_event(1,2)
	
func _ready() -> void:
	$Timer.wait_time = 1
