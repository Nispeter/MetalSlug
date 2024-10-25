extends Node
class_name health

@export var max_health : int = 100					#TODO: editor health not being applied
var current_health: int = max_health 
var is_dead: bool = false

func new_game():
	current_health = max_health
	is_dead = false

func get_health() -> int:
	return current_health
	
func take_damage(damage: int) -> void:
	current_health -= damage
	if current_health <= 0:
		die()
		
	print("damage taken: %d, current health: %d" %[damage, current_health])
	
func heal(heal: int) -> void: 
	current_health += heal
	
func get_alive() -> bool: 
	return is_dead

func die():
	current_health = 0
	is_dead = true
