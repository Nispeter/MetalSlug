extends Node2D
class_name weapon

@export var has_life_time: bool
@export var weapon_life_time: float

func _ready():
	pass

func attack():
	pass

func activate():
	set_process(true)
	set_physics_process(true)
	visible = true

func deactivate():
	set_process(false)
	set_physics_process(false)
	visible = false

	for child in get_children():
		if child is Timer:
			child.stop()
		elif child is AnimationPlayer:
			child.stop()
