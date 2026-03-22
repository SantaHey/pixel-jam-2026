extends Sprite2D

class_name Key_button

@export var id_name = "q"

var t_up
var t_down

var last = false
var pressed = false
var unlocked = false

var multiplicator: float = 1.0

var chaos_percent:float = 0.0
var particles:int = 30
var par_scale:int = 1
var par_rotate:int = 200
var par_speed:int = 10

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
	
	$Multiplicator.text = "X " + str(multiplicator)
	
func _create_particles() -> void:
	chaos_percent = 1 if chaos_percent > 1 else chaos_percent
	var truc:ParticleProcessMaterial = $GPUParticles2D.process_material.duplicate()
	truc.angular_velocity_max = par_rotate * chaos_percent
	truc.scale_max = par_scale * chaos_percent + 0.1
	truc.scale_min = truc.scale_max
	$GPUParticles2D.process_material = truc
	$GPUParticles2D.scale = Vector2(par_speed * chaos_percent + 0.1, par_speed * chaos_percent + 0.1)
	$GPUParticles2D.amount = int(particles * chaos_percent) + 1
	var p = $GPUParticles2D.duplicate()
	add_child(p)
	p.restart()
	
func _draw() -> void:
	var t_to_draw = t_down if pressed else t_up
	if unlocked:
		$ColorRect.visible = false
		draw_texture(t_to_draw, Vector2(0,0), Color(1,1,1,1))
	else:
		$ColorRect.visible = true
		draw_texture(t_down, Vector2(0,0), Color(0.886, 0.671, 0.729, 1.0))
