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
	j1_event_target_key_string = event_data[1][0]
	j2_event_target_key_string = event_data[1][1]
	is_event_active = true
	
	#print("Le joueur 1 doit appuyer ", event_target_presses, " fois sur la touche ", j1_event_target_key_string)
	# Tools.showdebugtext("event_j1", "J1 doit appuyer " + str(event_target_presses) + " fois sur la touche " + j1_event_target_key_string)
	#print("Le joueur 2 doit appuyer ", event_target_presses, " fois sur la touche ", j2_event_target_key_string)
	# Tools.showdebugtext("event_j2", "J2 doit appuyer " + str(event_target_presses) + " fois sur la touche " + j2_event_target_key_string)
	#print("La récompense est un ", event_reward_type)

func generate_event():
	$EventTriggerTimer.stop()
	var nb_pressed = randi_range(5,15)
	var keys = get_random_keys()
	#print(nb_pressed)
	#print(index_key)
	return [nb_pressed,keys]

func get_random_keys():
	var l1 = get_available_key(1)
	var l2 = get_available_key(2)
	l1.shuffle()
	l2.shuffle()
	#Get the first key of the list (previously shuffle)
	var j1k = l1.pop_front()
	var j2k = l2.pop_front()
	return [j1_event_target_key_string, j2_event_target_key_string]

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
	
	# DISPLAY
	var displayed_text_j1 = ""
	var displayed_text_j2 = ""

	# 3. Logique pour le JOUEUR 1
	if player_id == 1:
		if lower_key == j1_event_target_key_string:
			j1_current_presses += 1
			# print("J1 OK ! Progression : ", j1_current_presses, "/", event_target_presses)
			# Tools.showdebugtext("event_j1", "Progression J1 : " + str(j1_current_presses) + "/" + str(event_target_presses))

			# DISPLAY TEXT
			displayed_text_j1 = "Press only " + j1_event_target_key_string + " : " + str(j1_current_presses) + "/" + str(event_target_presses)

			# WIN CONDITION
			if j1_current_presses >= event_target_presses:
				win_event(1)
		else:
			if j1_current_presses > 0:
				j1_current_presses = 0
				# print("Erreur J1 ! Le compteur retombe à 0.")
				# Tools.showdebugtext("event_j1", "Erreur J1 ! Progression retombe à 0.")
				
				# DISPLAY TEXT
				# Text ERROR ! Press only B 10 times in a row
				displayed_text_j1 = "ERROR ! Press only " + j1_event_target_key_string + " " + str(event_target_presses) + " times in a row."
				
	# 4. Logique pour le JOUEUR 2
	elif player_id == 2:
		if lower_key == j2_event_target_key_string:
			j2_current_presses += 1
			# print("J2 OK ! Progression : ", j2_current_presses, "/", event_target_presses)
			# Tools.showdebugtext("event_j2", "Progression J2 : " + str(j2_current_presses) + "/" + str(event_target_presses))

			# DISPLAY TEXT
			displayed_text_j2 = "Press only " + j2_event_target_key_string + " : " + str(j2_current_presses) + "/" + str(event_target_presses)

			# WIN CONDITION
			if j2_current_presses >= event_target_presses:
				win_event(2)
		else:
			if j2_current_presses > 0:
				j2_current_presses = 0
				# print("Erreur J2 ! Le compteur retombe à 0.")
				# Tools.showdebugtext("event_j2", "Erreur J2 ! Progression retombe à 0.")
				
				# DISPLAY TEXT
				displayed_text_j2 = "ERROR ! Press only " + j2_event_target_key_string + " " + str(event_target_presses) + " times in a row."

	# DISPLAY TEXT
	Global.text_j1 = displayed_text_j1
	Global.text_j2 = displayed_text_j2

# EVENT REWARD
func win_event(player_id):
	# print("🏆 Le Joueur ", player_id, " a terminé l'event en premier !")

	is_event_active = false
	
	if event_reward_type == "bonus":
		# print("Le joueur ", player_id, " voit ", event_reward_power, " de ses touches améliorées")
		trigger_event("bonus", player_id, event_reward_power)
	else:
		var loser_id = 1
		if player_id == 1:
			loser_id = 2
		trigger_event("malus", loser_id, event_reward_power)
		# print("Le joueur ", loser_id, " subit un malus sur ", event_reward_power, " touches")


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
	var displayed_text_winner = ""
	var displayed_text_loser = ""

	# BONUS EVENT
	if event_name == "bonus":
		# print("trigger bonus for player ", id)
		var selected_keys = select_random_key(id,n)
		# print(selected_keys)
		events["bonus"].set("keys", selected_keys)
		
		var bonus_value = events[event_name]["value"]
		for k in selected_keys:
			Global.keys_state[k].multiplicator *= bonus_value
			Global.keys_state[k].event = "noevent"

		# DISPLAYED TEXT
		displayed_text_winner += "Event won : "
		for hmap_key in selected_keys:
			displayed_text_winner += hmap_key + " "
		displayed_text_winner += "boosted by " + str(bonus_value) + " for " + str(round($EventDurationTimer.wait_time)) + "s!"

		displayed_text_loser += "Event lost, you missed the bonus..."
	
	# MALUS EVENT
	if event_name == "malus":
		# print("trigger malus for player ", id)
		var selected_keys = select_random_key(id,n)
		# print(selected_keys)
		events[event_name].set("keys", selected_keys)
		
		var malus_value = events[event_name]["value"]
		var previous_values = []
		for k in selected_keys:
			previous_values.append(Global.keys_state[k].multiplicator)
			Global.keys_state[k].multiplicator *= malus_value
			Global.keys_state[k].event = "noevent"

		events[event_name].set("previous_values", previous_values)

		# DISPLAYED TEXT
		displayed_text_loser += "Event lost : "
		for hmap_key in selected_keys:
			displayed_text_loser += hmap_key + " "
		displayed_text_loser += "malused by " + str(malus_value) + " for " + str(round($EventDurationTimer.wait_time)) + "s!"

		displayed_text_winner += "Event won, you avoided the malus !"

	# DISPLAY TEXT
	if id == 1:
		# player1 won
		Global.text_j1 = displayed_text_winner
		Global.text_j2 = displayed_text_loser
	else:
		# player2 won
		Global.text_j2 = displayed_text_winner
		Global.text_j1 = displayed_text_loser

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
		
		# DISPLAYED TEXT

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
