extends health

signal loose_lives

func die():
	current_health = 0
	loose_lives.emit()
