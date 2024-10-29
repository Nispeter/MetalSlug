extends Node

@export var selected_weapon: WeaponTypes.WeaponType

var current_weapon: Node
var default_weapon: Node
var life_timer: Timer

func _ready():
	life_timer = Timer.new()
	life_timer.one_shot = true
	add_child(life_timer)
	life_timer.timeout.connect(_on_life_timer_timeout)

	deactivate_all_children()
	var weapon_name = WeaponTypes.get_string_from_enum(selected_weapon)
	default_weapon = get_node(weapon_name)
	current_weapon = default_weapon
	change_weapon(weapon_name)
	
func change_weapon(weapon_name: String):
	var weapon_to_change: Node = get_node(weapon_name) 
	if !weapon_to_change:
		return

	if current_weapon:
		current_weapon.deactivate()

	current_weapon = weapon_to_change
	current_weapon.activate()

	if  current_weapon.has_life_time:
		life_timer.start(current_weapon.weapon_life_time)
	
func deactivate_all_children():
	for child in get_children():
		if child.has_method("deactivate"):
			child.deactivate()
			
func restore_default_weapon():
	if current_weapon:
		current_weapon.deactivate()
		current_weapon = default_weapon
		current_weapon.activate()

func _on_life_timer_timeout():
	restore_default_weapon()
