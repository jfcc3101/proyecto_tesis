extends KinematicBody2D

const ARRIBA = Vector2(0,-1)
const ACELERACION = 15
const VELOCIDAD_MAX  = 300
export var mov = Vector2()
#var posCamara = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_process(true)
	pass # Replace with function body.


func _process(delta):
	var posCamara = get_node("/root/Mundo/Jugador/Camera2D").get_camera_position()
	translate(mov * delta)
	#mov.y = -100
	$AnimatedSprite.play("default")
	if position.y >= posCamara.y+100:
		queue_free()
	move_and_slide(mov, ARRIBA)
	
