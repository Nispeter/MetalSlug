extends weapon

@export var bullet_sc : PackedScene
@export var shoot_rate: float = 0.5

var can_shoot: bool = true
var _sooting_dir: Vector2 = Vector2.RIGHT

func _ready():
	pass

func attack():
	shoot()
	
func shoot():
	if can_shoot:
		var bullet_obj = bullet_sc.instantiate() as bullet 				#TODO: pool bullets instead for better performance
		bullet_obj.position = position									#FIXME: bullet moving with player, using glopbal_position spawns bullet far away, currently tied to player in tree
		bullet_obj.set_direction(_sooting_dir)							#NOTE: currently only works for right shooting 
		get_parent().add_child(bullet_obj)
		
		can_shoot = false
		await get_tree().create_timer(shoot_rate).timeout
		can_shoot = true

func _process(delta: float):
	if Input.is_action_just_pressed("attack"):
		attack()
