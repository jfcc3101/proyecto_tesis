extends StaticBody2D

func _ready():
	set_process(true)
	
	pass # Replace with function body.


func _process(delta):
	
	
	if not get_node("VisibilityNotifier2D").is_on_screen():
		queue_free()
	pass
