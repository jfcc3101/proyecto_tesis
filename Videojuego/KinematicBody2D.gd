extends KinematicBody2D

const ARRIBA = Vector2(0,-1)
const ACELERACION = 15
const VELOCIDAD_MAX  = 300
var mov = Vector2()
var pos_izq = Vector2()
var pos_der = Vector2()
const esc_bala = preload("res://Bala.tscn")

func _ready():
	pass


func _physics_process(delta):
	pos_canones()
	var spawner = get_node("/root/Mundo/EnemySpawner")
	mov.y = -110
	if Input.is_action_pressed("ui_right"):
		mov.x = min(mov.x+ACELERACION,VELOCIDAD_MAX)
		$AnimatedSprite.play("right")
		#$AnimatedSprite.self_modulate = Color(0.2,0.3,0.1)
	elif Input.is_action_pressed("ui_left"):
		mov.x = max(mov.x-ACELERACION,-VELOCIDAD_MAX)
		$AnimatedSprite.play("left")
	elif Input.is_action_just_pressed("ui_up"):
		crear_laser(pos_izq)
		crear_laser(pos_der)
		#spawner.spawnCassette()
		pass
	elif Input.is_action_just_pressed("ui_down"):
		randomize()
		var enemigo = rand_range(0,3)
		if enemigo <= 1:
			spawner.spawnCassette()
		elif enemigo <= 2:
			spawner.spawnDisc()
		else:
			spawner.spawnMPlayer()
		pass
		#mov.y = min(mov.y+ACELERACION,VELOCIDAD_MAX)
	else:
		$AnimatedSprite.play("normal")
		
	move_and_slide(mov, ARRIBA)
	
func pos_canones():
	pos_izq = self.position
	pos_izq.x -=24
	pos_izq.y -=12
	get_node("Canones/izq").set_position(pos_izq)
	pos_der = self.position
	pos_der.x +=24
	pos_der.y -=12
	get_node("Canones/der").set_position(pos_der)
	pass
	
func crear_laser(pos):
	var bala = esc_bala.instance()
	bala.set_position(pos)
	get_node("/root").add_child(bala)
	pass
	