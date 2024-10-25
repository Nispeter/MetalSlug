extends interactable
class_name collectible 

func _ready():
	hint_string = "pick up"

func _on_area_entered(body:Node):
	if body.is_in_group("player"):
		queue_free()
	
