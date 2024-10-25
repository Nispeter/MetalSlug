extends collectible

@export var heal_value: int = 10
@export var float_speed: float = 1.0 
@export var float_amplitude: float = 10.0  

var original_y: float

func _ready():
	original_y = position.y  

func _process(delta: float) -> void:
	# position.y = original_y + sin(Time.get_ticks_msec() / 1000.0 * float_speed) * float_amplitude
	pass
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if body.has_node("health_controller"):
			print("healing "+ str(heal_value) +" points")
			body.health_controller.heal(heal_value)
		queue_free()
