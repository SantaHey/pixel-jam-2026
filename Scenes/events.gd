extends Node

var is_event_active = false
var j1_event_target_key_string : String = ""
var j2_event_target_key_string : String = ""
var event_target_presses : int = 0

var event_reward_type : String = ""
var event_reward_power : int = 3

var j1_current_presses = 0
var j2_current_presses = 0

func _ready() -> void:
	print("fdsdjf")
	#Tools.showdebugtext("children", str(get_children()))
	$EventTriggerTimer.wait_time = 1

func _on_event_trigger_timer_timeout() -> void:
	start_new_event()

# EVENT GENERATION
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
	Tools.showdebugtext("event_j1", "J1 doit appuyer " + str(event_target_presses) + " fois sur la touche " + j1_event_target_key_string)
	print("Le joueur 2 doit appuyer ", event_target_presses, " fois sur la touche ", j2_event_target_key_string)
	Tools.showdebugtext("event_j2", "J2 doit appuyer " + str(event_target_presses) + " fois sur la touche " + j2_event_target_key_string)
	print("La récompense est un ", event_reward_type)

func generate_event():
	$EventTriggerTimer.stop()
	var nb_pressed = randi_range(5,15)
	var index_key = get_common_keys()
	print(nb_pressed)
	print(index_key)
	return [nb_pressed,index_key]

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

func get_available_key(id):
	var available_key = []
	for key in Global.keys_state:
		if Global.keys_state[key]["state"] and Global.keys_state[key]["player"]==id :
			available_key.append(key)
	return available_key

# EVENT HANDLING
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

# EVENT REWARD
func win_event(player_id):
	print("🏆 Le Joueur ", player_id, " a terminé l'event en premier !")
	is_event_active = false
	
	if event_reward_type == "bonus":
		trigger_event("bonus", player_id, event_reward_power)
		print("Le joueur ", player_id, " voit ", event_reward_power, " de ses touches améliorées")
		Tools.showdebugtext("event_j"+str(player_id), "J" + str(player_id) + " a gagné un bonus ! : " + str(event_reward_power) + "x multiplicator sur " + str(event_reward_power) + " touches")
	else:
		var loser_id = 1
		if player_id == 1:
			loser_id = 2
		trigger_event("malus", loser_id, event_reward_power)
		print("Le joueur ", loser_id, " subit un malus sur ", event_reward_power, " touches")
		Tools.showdebugtext("event_j"+str(player_id), "J" + str(player_id) + " a gagné un bonus ! : " + str(event_reward_power) + "x multiplicator sur " + str(event_reward_power) + " touches")


var events = {
	"bonus" : {
		"value": 5,
		"keys": [],
	},
	"malus" : {
		"value": 0,
		"keys": [],
		"previous_values": []
	},
}

func trigger_event(event_name, id,n):
	# BONUS EVENT
	if event_name == "bonus":
		print("trigger bonus for player ", id)
		var selected_keys = select_random_key(id,n)
		print(selected_keys)
		events["bonus"].set("keys", selected_keys)
		
		var bonus_value = events[event_name]["value"]
		for k in selected_keys:
			Global.keys_state[k].multiplicator *= bonus_value
			Global.keys_state[k].event = "noevent"
	
	# MALUS EVENT
	if event_name == "malus":
		print("trigger malus for player ", id)
		var selected_keys = select_random_key(id,n)
		print(selected_keys)
		events[event_name].set("keys", selected_keys)
		
		var malus_value = events[event_name]["value"]
		var previous_values = []
		for k in selected_keys:
			previous_values.append(Global.keys_state[k].multiplicator)
			Global.keys_state[k].multiplicator *= malus_value
			Global.keys_state[k].event = "noevent"

		events[event_name].set("previous_values", previous_values)

	# ON START L'EVENEMENT
	$EventDurationTimer.start()

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
	# print timer remaining time for debug
	if $EventDurationTimer.is_stopped() == false:
		Tools.showdebugtext("event_timer", str(round($EventDurationTimer.time_left)) + "s")
	
	Tools.showdebugtext("power_malus", events["malus"])
	Tools.showdebugtext("power_bonus", events["bonus"])

# CANCEL REWARD
func _on_event_duration_timer_timeout() -> void:
	var event_name = ""
	
	# FOR BONUS
	event_name = "bonus"
	for key_button in events[event_name]["keys"]:
		# si l'event est en cours
		var bonus_value = events[event_name]["value"]
		Global.keys_state[key_button].multiplicator /= bonus_value
		# set to normal
		Global.keys_state[key_button].event = "noevent"
		# reset keys
		events[event_name].set("keys", [])
	
	# FOR MALUS
	event_name = "malus"
	for key_button in events[event_name]["keys"]:
		# si l'event est en cours
		var malus_value = events[event_name]["value"]
		# RESTORE PREVIOUS VALUE
		var previous_value = events[event_name]["previous_values"].pop_front()
		Global.keys_state[key_button].multiplicator = previous_value
		# set to noevent
		Global.keys_state[key_button].event = "noevent"
		# reset keys
		events[event_name].set("keys", [])

	# ON RESTART L'EVENEMENT
	$EventTriggerTimer.start()
