extends Control
class_name screen

func _ready():
	self.hide() 

func show_screen():
	self.show()
	print("Showing screen: ", self.name)

func hide_screen():
	self.hide()
	print("Hiding screen: ", self.name)
