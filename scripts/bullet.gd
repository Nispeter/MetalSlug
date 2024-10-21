extends damage_dealer
class_name bullet

@export var  speed: float = 600.0
@export var lifetime: float = 10.0

var direction: Vector2
func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
func _process(delta:float):
	position += direction * speed * delta
	
func set_direction (dir: Vector2):
	direction = dir
	
func _on_body_entered(body: Node):
	deal_damage(body)
	queue_free()
