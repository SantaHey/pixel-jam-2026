extends Node2D

var mouse_click_pos:Vector2 = Vector2(0,0)
var btn_clicked = -1

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if not $AnimationPlayer.is_playing():
			mouse_click_pos = get_global_mouse_position()
			print(mouse_click_pos)
			btn_clicked = -1
			if 18 < mouse_click_pos.x and mouse_click_pos.x < 104:
				if 89 < mouse_click_pos.y and mouse_click_pos.y < 119:
					btn_clicked = 0
			
			if 18 < mouse_click_pos.x and mouse_click_pos.x < 132:
				if 132 < mouse_click_pos.y and mouse_click_pos.y < 161:
					btn_clicked = 1
			
			if 201 < mouse_click_pos.x and mouse_click_pos.x < 286:
				if 132 < mouse_click_pos.y and mouse_click_pos.y < 161:
					btn_clicked = 2

		print(btn_clicked)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("new_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match btn_clicked:
		0:
			get_tree().change_scene_to_file("res://Scenes/game.tscn")
		1:
			$RichTextLabel.show()
		2:
			get_tree().quit()
