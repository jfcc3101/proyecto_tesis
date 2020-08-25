extends AnimatedSprite

var borrable

# Called when the node enters the scene tree for the first time.
func _ready():
	var borrable = false
	self.play("default")
	pass # Replace with function body.


func _process(delta):
	pass


func _on_VisibilityNotifier2D_screen_entered():
	borrable = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	if borrable == true:
		queue_free()
	pass # Replace with function body.
