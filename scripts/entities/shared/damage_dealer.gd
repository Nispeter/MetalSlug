extends Area2D
class_name damage_dealer

@export var damage_amount: int = 10
@export var target_object_id: int = 0

func deal_damage(target: Object) -> void: 
	if target.has_node("health_controller"):
		var health_controller = target.get_node("health_controller")
		if health_controller.has_method("take_damage"):
			health_controller.take_damage(damage_amount)
		
func _on_body_entered(body: Node) -> void:
	print("dealing damage!")
	deal_damage(body)
