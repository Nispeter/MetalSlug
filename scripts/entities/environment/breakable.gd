extends health
class_name breakable

func die():
	get_parent().queue_free()
