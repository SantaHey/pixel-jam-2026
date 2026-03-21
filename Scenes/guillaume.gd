extends Node2D

var state: Dictionary = {}

func update_keys() -> void:
	for i in get_children():
		if is_instance_of(i, Key_button):
			var key_id = i.id_name
			print(key_id)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_keys()
