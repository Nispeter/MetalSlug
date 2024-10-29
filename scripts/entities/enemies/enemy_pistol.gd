extends weapon

#ALERT: this shit aint working yo

@export var bullet_sc: PackedScene  # The bullet scene to be instantiated
@export var shoot_rate: float = 0.5  # Time between shots

var can_shoot: bool = true

func _ready():
	# Get the Timer node and set its wait time
	var shoot_timer = $Timer
	shoot_timer.wait_time = shoot_rate
	shoot_timer.start()  # Start the timer to begin shooting

func _on_Timer_timeout():
	if can_shoot:
		attack()

func attack():
	if bullet_sc:
		var bullet_instance = bullet_sc.instantiate()  
		get_parent().add_child(bullet_instance)  
		bullet_instance.global_position = global_position  
		print("Bullet fired from enemy!")
	else:
		print("Error: bullet_sc not set.")
