extends Node
class_name screen_manager
#NOTE: screen_manager is a initialized by Global class singleton, refer to project > project settings > globals for additional configuration

@export var screen_a : screen 				
@export var screen_b : screen 

var screen_stack: Array = []

func _ready():
	if screen_a == null or screen_b == null:
		print("Error on screen allocation")
	pass

func _process(delta: float)-> void:
	if Input.is_action_just_pressed("pause"):
		if(screen_stack.size() > 1):
			close_screen()
		else:
			open_screen(screen_a)

func open_screen(opening_screen: screen):
	if screen_stack.size() > 0:
		screen_stack[screen_stack.size() - 1].hide()  
	screen_stack.push_back(opening_screen)  
	opening_screen.show_screen()  
	print("Opened screen: ", opening_screen.name)

func close_screen():
	if screen_stack.size() > 0:
		var current_screen = screen_stack.pop_back()  
		current_screen.hide_screen()  
		print("Closed screen: ", current_screen.name)
		
		if screen_stack.size() > 0:
			var previous_screen = screen_stack[screen_stack.size() - 1]
			previous_screen.show_screen()
			print("Returned to screen: ", previous_screen.name)

func is_screen_open() -> bool:
	return screen_stack.size() > 0

func get_current_screen() -> screen:
	if screen_stack.size() > 0:
		return screen_stack[screen_stack.size() - 1]
	return null
