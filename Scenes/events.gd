extends Node

var bonus = 2
var malus = 0

var is_event_active = false
var j1_event_target_key_string : String = ""
var j2_event_target_key_string : String = ""
var event_target_presses : int = 0

var event_reward_type : String = ""
var event_reward_power : int = 3

var j1_current_presses = 0
var j2_current_presses = 0

func start_new_event():
	
	j1_current_presses = 0
	j2_current_presses = 0
	
	if randf() > 0.5:
		event_reward_type = "bonus"
	else :
		event_reward_type = "malus"
	
	var event_data = generate_event()
	event_target_presses = event_data[0]
	var target_vector = event_data[1]
	for k in Global.keys_state :
		if Global.keys_state[k].player==1 and Global.keys_state[k].line==int(target_vector[0]) and Global.keys_state[k].col==int(target_vector[1]) :
			j1_event_target_key_string=k
		if Global.keys_state[k].player==2 and Global.keys_state[k].line==int(target_vector[0]) and Global.keys_state[k].col==int(target_vector[1]) :
			j2_event_target_key_string=k
	is_event_active = true
	
	print("Le joueur 1 doit appuyer ", event_target_presses, " fois sur la touche ", j1_event_target_key_string)
	print("Le joueur 2 doit appuyer ", event_target_presses, " fois sur la touche ", j2_event_target_key_string)
	print("La récompense est un ", event_reward_type)

func generate_event():
	$Timer.stop()
	var nb_pressed = randi_range(10,50)
	var index_key = get_common_keys()
	print(nb_pressed)
	print(index_key)
	return [nb_pressed,index_key]
	
func win_event(id):
	print("🏆 Le Joueur ", id, " a terminé l'event en premier !")
	is_event_active = false
	
	if event_reward_type == "bonus":
		bonus_event(id, event_reward_power)
		print("Le joueur ", id, " voit ", event_reward_power, " de ses touches améliorées")
	else:
		var loser_id = 1
		if id == 1:
			loser_id = 2
		malus_event(loser_id, event_reward_power)
		print("Le joueur ", loser_id, " subit un malus sur ", event_reward_power, " touches")
	end_event()
	
func end_event():
	$Timer.start()

func _unhandled_input(event: InputEvent) -> void:
	if not is_event_active:
		return
	if event is InputEventKey and event.pressed and not event.is_echo():
		var pressed_key_string = OS.get_keycode_string(event.keycode)
		process_player_input(pressed_key_string)

func process_player_input(pressed_key: String):
	# On passe la touche en minuscule pour correspondre à ton dictionnaire ("Q" devient "q")
	var lower_key = pressed_key.to_lower()
	
	# 1. On vérifie si la touche fait partie du jeu
	if not Global.keys_state.has(lower_key):
		return # C'est une touche hors jeu (ex: Espace, Echap), on l'ignore
		
	# 2. On identifie à quel joueur appartient la touche pressée
	var player_id = Global.keys_state[lower_key]["player"]
	
	# 3. Logique pour le JOUEUR 1
	if player_id == 1:
		if lower_key == j1_event_target_key_string:
			j1_current_presses += 1
			print("J1 OK ! Progression : ", j1_current_presses, "/", event_target_presses)
			if j1_current_presses >= event_target_presses:
				win_event(1)
		else:
			if j1_current_presses > 0:
				j1_current_presses = 0
				print("Erreur J1 ! Le compteur retombe à 0.")
				
	# 4. Logique pour le JOUEUR 2
	elif player_id == 2:
		if lower_key == j2_event_target_key_string:
			j2_current_presses += 1
			print("J2 OK ! Progression : ", j2_current_presses, "/", event_target_presses)
			if j2_current_presses >= event_target_presses:
				win_event(2)
		else:
			if j2_current_presses > 0:
				j2_current_presses = 0
				print("Erreur J2 ! Le compteur retombe à 0.")

# Event Result
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

func _on_timer_timeout() -> void:
	start_new_event()

func _ready() -> void:
	$Timer.wait_time = 30
