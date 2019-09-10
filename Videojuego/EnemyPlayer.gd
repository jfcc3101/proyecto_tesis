extends KinematicBody2D

const ARRIBA = Vector2(0,-1)
const ACELERACION = 15
const VELOCIDAD_MAX  = 300
var mov = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	mov.y = -100
	$AnimatedSprite.play("default")
	move_and_slide(mov, ARRIBA)
