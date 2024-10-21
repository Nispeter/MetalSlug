extends Node

var player_body: CharacterBody2D

# Movement parameters								#TODO: add max linear speed and make normal running speed lower, so momentum can be applied
@export var advanced_movement : bool = true
@export var speed: float = 200.0					#WARNING: on low values, edge detecion explodes
@export var jump_force: float = 500.0
@export var gravity: float = 2000.0
@export var max_fall_speed: float = 4000.0
@export var acceleration: float = 50.0
@export var air_control: float = 0.8

# Jump parameters
@export var coyote_time_duration: float = 0.2
@export var jump_buffer_duration: float = 10		#NOTE: modify for timed jumps
@export var variable_jump_height: float = 0.6
@export var max_jumps: int = 1

# Wall jump parameters
@export var wall_jump_force: Vector2 = Vector2(300, -400)
@export var wall_slide_speed: float = 100.0
@export var wall_jump_cooldown: float = 0.2

# Dash parameters
@export var dash_speed: float = speed * 4
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.5

# Internal state
var is_jumping: bool = false
var is_dashing: bool = false
var can_wall_jump: bool = false
var facing_direction: int = 1
var jump_count: int = 0  

var coyote_time: float = 0.0
var jump_buffer_time: float = 0.0
var dash_time: float = 0.0
var dash_cooldown_time: float = 0.0
var wall_jump_cooldown_time: float = 0.0

var move_input: float = 0.0
var is_on_wall: bool = false
var is_on_ground: bool = false

signal on_dash

func _ready() -> void:
	player_body = get_parent() as CharacterBody2D

func _physics_process(delta: float) -> void:
	if not player_body.is_on_floor() and not is_dashing:
		player_body.velocity.y += gravity * delta
		player_body.velocity.y = min(player_body.velocity.y, max_fall_speed)

	if player_body.is_on_floor():
		coyote_time = coyote_time_duration
		jump_count = 0
	else:
		coyote_time -= delta

	jump_buffer_time -= delta
	wall_jump_cooldown_time -= delta
	dash_cooldown_time -= delta

	handle_horizontal_movement(delta)
	handle_jumping()
	handle_dashing(delta)

	player_body.move_and_slide()

	if player_body.is_on_floor() and is_dashing:
		is_dashing = false
		dash_time = 0

func handle_horizontal_movement(delta: float) -> void:
	move_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	var target_speed = move_input * speed
	var accel = acceleration if player_body.is_on_floor() else acceleration * air_control

	player_body.velocity.x = lerp(player_body.velocity.x, target_speed, accel * delta)

	if move_input != 0:
		facing_direction = sign(move_input)

func handle_jumping() -> void:
	#print(jump_count)
	if is_on_wall and not player_body.is_on_floor() and Input.is_action_just_pressed("jump") and wall_jump_cooldown_time <= 0:
		player_body.velocity = wall_jump_force * Vector2(facing_direction * -1, 1)
		wall_jump_cooldown_time = wall_jump_cooldown
	elif Input.is_action_just_pressed("jump") and (player_body.is_on_floor() or (jump_count < max_jumps and advanced_movement)):
		if(coyote_time <= 0 and jump_count  == 0):				#HACK: no es bonito, pero hace el trabajo
			jump_count += 1
		player_body.velocity.y = -jump_force
		is_jumping = true
		coyote_time = 0.0
		jump_buffer_time = 0.0
		jump_count += 1 
	elif is_jumping and not Input.is_action_pressed("jump"):
		if player_body.velocity.y < 0:
			player_body.velocity.y *= variable_jump_height
		is_jumping = false

	if Input.is_action_just_pressed("jump"):
		jump_buffer_time = jump_buffer_duration

func handle_dashing(delta: float) -> void:
	if !advanced_movement: return 
	if Input.is_action_just_pressed("dash") and dash_cooldown_time <= 0 and not is_dashing:
		is_dashing = true
		dash_time = dash_duration
		dash_cooldown_time = dash_cooldown
		emit_signal("on_dash")

	if is_dashing:
		if player_body.is_on_floor():
			player_body.velocity.x = facing_direction * dash_speed 						#TODO: reduce friction on grounded dash
		else:
			player_body.velocity.x = facing_direction * dash_speed
		
		dash_time -= delta
		if dash_time <= 0:
			is_dashing = false

	is_on_wall = is_on_wall_detected()
	if is_on_wall and player_body.velocity.y > 0:
		player_body.velocity.y = min(player_body.velocity.y, wall_slide_speed)


func is_on_wall_detected() -> bool:
	return player_body.get_slide_collision_count() > 0 and not player_body.is_on_floor()
