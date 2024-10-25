extends ProgressBar

var _max_health : int
var _current_health : int
var health_controller : Node

func _ready():
	health_controller = $"player/health_controller"						#WARNING: code not working and its not necessary 
	new_game()

	
func new_game():
	pass
