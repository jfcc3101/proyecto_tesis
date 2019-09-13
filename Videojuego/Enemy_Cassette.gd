extends Area2D

export var velocidad = Vector2()

func _ready():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(velocidad * delta)
	$AnimatedSprite.play("default")
	if position.y >= 10:
		queue_free()
	pass
