extends CharacterBody2D

@export var spawn_point: Node

var health_controller : Node
var movement_controller : Node
var weapon_controller : Node

@export var live_counter : Label
@export var score_counter: Label
@export var max_lives : int
var current_lives : int
var current_score : int

func _ready():
	health_controller = $health_controller
	movement_controller = $movement_controller
	weapon_controller = $weapon_controller
	new_game()
	
func new_game():
	health_controller.new_game()
	spawn_player()
	current_lives = max_lives
	current_score = 0
	live_counter.text = "LIVES: " + str(current_lives)

func spawn_player():
	if spawn_point:
		position = spawn_point.position
	pass
	
func add_score(score_value: int):
	current_score += score_value
	score_counter.text = "score: " + str(current_score)

func _loose_live():
	current_lives -= 1
	live_counter.text = "LIVES: " + str(current_lives)
	if current_lives < 1:
		loose_game()
	else: spawn_player()
	
func loose_game():
	print("you lost!")
	pass
	
func change_weapon(weapon_name: String):
	weapon_controller.change_weapon(weapon_name)
	
