extends Sprite2D

class_name Key_button

@export var id_name = "q"

var t_up
var t_down

var last = false
var pressed = false
var unlocked = false

var multiplicator: float = 1.0

func _ready() -> void:
	$Placeholder.hide()
	load_textures()

func load_textures():
	t_up = load("res://sprite/keys/" + id_name.to_upper() + "-up.png")
	t_down = load("res://sprite/keys/" + id_name.to_upper() + "-down.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if last != pressed and pressed:
		_create_particles()
	
	last = pressed
	
	queue_redraw()
	
	$Multiplicator.text = str(multiplicator)
	
func _create_particles() -> void:
	# TODO look into particle emitter, modif with score
	var p = $CPUParticles2D.duplicate()
	add_child(p)
	p.restart()
	# q$CPUParticles2D.emitting = true
	pass
	
func _draw() -> void:
	var t_to_draw = t_down if pressed else t_up
	if unlocked:
		$ColorRect.visible = false
		draw_texture(t_to_draw, Vector2(0,0), Color(1,1,1,1))
	else:
		$ColorRect.visible = true
		draw_texture(t_down, Vector2(0,0), Color(0.886, 0.671, 0.729, 1.0))
