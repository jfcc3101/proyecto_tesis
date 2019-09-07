extends KinematicBody2D

const ARRIBA = Vector2(0,-1)
const ACELERACION = 15
const VELOCIDAD_MAX  = 300
var mov = Vector2()

func _physics_process(delta):
	mov.y = -110
	if Input.is_action_pressed("ui_right"):
		mov.x = min(mov.x+ACELERACION,VELOCIDAD_MAX)
		$AnimatedSprite.play("right")
		#$AnimatedSprite.self_modulate = Color(0.2,0.3,0.1)
	elif Input.is_action_pressed("ui_left"):
		mov.x = max(mov.x-ACELERACION,-VELOCIDAD_MAX)
		$AnimatedSprite.play("left")
	elif Input.is_action_pressed("ui_up"):
		pass
	elif Input.is_action_pressed("ui_down"):
		pass
		#mov.y = min(mov.y+ACELERACION,VELOCIDAD_MAX)
	else:
		$AnimatedSprite.play("normal")
		
	move_and_slide(mov, ARRIBA)
	
# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
