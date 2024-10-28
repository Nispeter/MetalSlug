extends Node2D
class_name weapon

@export var has_life_time: bool
@export var weapon_life_time: float

# Timer variable
var lifetime_timer: Timer

func _ready():
	if has_life_time:
		lifetime_timer = Timer.new()
		lifetime_timer.wait_time = weapon_life_time
		lifetime_timer.one_shot = true
		lifetime_timer.connect("timeout", Callable(self, "_on_lifetime_timeout"))
		add_child(lifetime_timer)  

func attack():
	pass

func activate():
	set_process(true)
	set_physics_process(true)
	visible = true
	
	if has_life_time and lifetime_timer:
		lifetime_timer.start() 

func deactivate():
	set_process(false)
	set_physics_process(false)
	visible = false
	
	if lifetime_timer:
		lifetime_timer.stop()
		lifetime_timer.start() 

	for child in get_children():
		if child is Timer:
			child.stop()
		elif child is AnimationPlayer:
			child.stop()

func _on_lifetime_timeout():
	deactivate()  
