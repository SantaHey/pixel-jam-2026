extends Node

var bonus = 2
var malus = 0

var pressed_keys = []

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.echo:
			# If the event is an echo event, skip it
			return
		if event.pressed:
			pressed_keys.push_back(event.keycode)
		else:
			pressed_keys.erase(event.keycode)

func generate_event():
	$Timer.stop()
	
	
func get_common_keys():
	var common_key = []
	var l1 = transform_key_pos(get_available_key(1))
	var l2 = transform_key_pos(get_available_key(2))
	for l in l1:
		for m in l2:
			if l == m:
				common_key.append(l)
	return common_key[randi_range(0,len(common_key)-1)]

func transform_key_pos(list) :
	var l = []
	for k in list:
		l.append(Vector2(Global.keys_state[k]["line"],Global.keys_state[k]["col"]))
	return l

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
		if Global.keys_state[key]["state"] and Global.keys_state[key]["player"]==id :
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
	get_common_keys()
	
func _ready() -> void:
	$Timer.wait_time = 1
