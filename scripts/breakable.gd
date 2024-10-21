extends health
class_name Breakable

func die():
	get_parent().queue_free()
