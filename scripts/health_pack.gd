extends collectible

@export var heal_value: int = 10
@export var float_speed: float = 1.0  # Speed of floating (higher value = faster)
@export var float_amplitude: float = 10.0  # Amplitude of floating (higher value = more movement)

# Track the original position
var original_y: float

func _ready():
	original_y = position.y  # Store the initial Y position

# This function runs every frame, creating a smooth floating effect
func _process(delta: float) -> void:
	# Sinusoidal motion for floating effect
	position.y = original_y + sin(OS.get_ticks_msec() / 1000.0 * float_speed) * float_amplitude

# Function to handle player interaction
func _on_body_entered(body: Node) -> void:
	print("something hit!")
	if body.is_in_group("player"):
		print("player hit!")
		if body.has_node("health_controller"):
			print("healing player!")
			body.health_controller.heal(heal_value)
		queue_free()
