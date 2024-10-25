extends health

func die():
	current_health = 0
	get_parent().queue_free()
