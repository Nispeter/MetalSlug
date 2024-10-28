extends interactable
class_name collectible 

@export_group("collectible properties")
@export var deactivate_on_collect : bool = true

func _ready():
	hint_string = "pick up"

func _on_body_entered(body:Node):
	if body.is_in_group("player"):
		collect(body)
		if deactivate_on_collect: queue_free()
	
func collect(body:Node):
	pass
