extends collectible

@export_group("weapon crate properties")
@export var weapon_type : WeaponTypes.WeaponType
var selected_weapon_type : String

func _ready():
	selected_weapon_type = WeaponTypes.get_string_from_enum(weapon_type)
	print(str(selected_weapon_type) + "a")

func collect(body:Node):
	if body.has_method("change_weapon"):
		print("Chaning weapon to " + selected_weapon_type)
		body.change_weapon(selected_weapon_type)
