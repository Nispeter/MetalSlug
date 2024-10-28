extends Node

enum WeaponType {pistol, smg}

var WeaponNames : = ["pistol", "smg"]

func get_string_from_enum(option:int):
	return WeaponNames[option]
