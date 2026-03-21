extends Node

@export var PalierDroite :Node2D
@export var PalierGauche :Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("q"):
		var animationplayer :AnimationPlayer = PalierDroite.get_child(0)
		animationplayer.play(&"new_animation")
