extends Object
class_name damage_dealer

@export var damage_amount: int = 10
@export var target_object_id: int = 0

func deal_damage(target: Object) -> void: 
	if target.has_method("take_damage"):				#TODO: search for damagable items (ones that inherit from health)
		target.take_damage(damage_amount) 
		
func _on_body_entered(body: Node) -> void:
	print("dealing damage!")
	deal_damage(body)
