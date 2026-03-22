extends Node2D

func _ready() -> void:
	if Global.winner == 1:
		$J1.show()
		# WINNER : J1\nGlobal.score_j1
		$J1/WINNER.text = "WINNER : J1\n" + "  " + str(int(Global.score_j1))
		print(Global.score_j1)
		$J1/LOSER.text = "LOSER : J2\n" + "  " + str(int(Global.score_j2))
	else:
		$J2.show()
		# WINNER : J2\nGlobal.score_j2
		$J2/WINNER.text = "WINNER : J2\n" + "  " + str(int(Global.score_j2))
		$J2/LOSER.text = "LOSER : J1\n" + "  " + str(int(Global.score_j1))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("r"):
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
