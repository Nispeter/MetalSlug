extends Node

@export var selected_weapon : WeaponTypes.WeaponType

var current_weapon : Node
var default_weapon : Node

func _ready():
	deactivate_all_children()
	var weapon_name = WeaponTypes.get_string_from_enum(selected_weapon)
	default_weapon = get_node(weapon_name)
	current_weapon = current_weapon
	change_weapon(weapon_name)
	
func change_weapon(weapon_name: String):
	var weapon_to_change : Node = get_node(weapon_name) 
	if (!weapon_to_change): return
	
	if current_weapon:
		current_weapon.deactivate()
	current_weapon = weapon_to_change
	current_weapon.activate()
	
func deactivate_all_children():
	for child in get_children():
		if child.has_method("deactivate"):
			child.deactivate()
		else:
			print("Child node does not have a deactivate method:", child.name)
