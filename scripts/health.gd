extends Object
class_name health

@export var max_health : int = 100
var current_health: int = max_health
var is_dead: bool = false

func get_health() -> int:
	return current_health
	
func take_damage(damage: int) -> void:
	print("damage taken: $damage, current health: $current_health" )
	current_health -= damage
	if current_health <= 0:
		current_health = 0
		is_dead = true
	
func heal(heal: int) -> void: 
	current_health += heal
	
func get_alive() -> bool: 
	return is_dead
