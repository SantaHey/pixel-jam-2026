extends Sprite2D

@export var id_name = "q"

var t_up
var t_down

var pressed = false

var t = 0

func _ready() -> void:
	load_textures()

func load_textures():
	t_up = load("res://sprite/keys/" + id_name.to_upper() + "-up.png")
	t_down = load("res://sprite/keys/" + id_name.to_upper() + "-down.png")
	print(t_down, t_up, id_name.to_upper())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	if t > 1:
		pressed = !pressed
		t = 0
		
	queue_redraw()
	
func _draw() -> void:
	var t_to_draw = t_down if pressed else t_up
	draw_texture(t_to_draw, Vector2(0,0), Color(1,1,1,1))
