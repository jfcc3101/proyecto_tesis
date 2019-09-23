extends KinematicBody2D

const ARRIBA = Vector2(0,-1)
const ACELERACION = 15
const VELOCIDAD_MAX  = 300
var mov = Vector2()
var pos_izq = Vector2()
var pos_der = Vector2()
var par_der = []
const esc_bala = preload("res://Bala.tscn")
const esc_pared = preload("res://Pared.tscn")

func _ready():
	pass


func _physics_process(delta):
	crear_paredes()
	pos_canones()
	var spawner = get_node("/root/Mundo/EnemySpawner")
	mov.y = -110
	if Input.is_action_pressed("ui_right"):
		mov.x = min(mov.x+ACELERACION,VELOCIDAD_MAX)
		$AnimatedSprite.play("right")
		for i in get_node("/root/Mundo/ParedDerecha").get_children():
			i.get_node("Sprite").self_modulate = Color(1,0.3,0)
		for i in get_node("/root/Mundo/ParedIzquierda").get_children():
			i.get_node("Sprite").self_modulate = Color(1,1,1)
		#$AnimatedSprite.self_modulate = Color(0.2,0.3,0.1)
	elif Input.is_action_pressed("ui_left"):
		mov.x = max(mov.x-ACELERACION,-VELOCIDAD_MAX)
		$AnimatedSprite.play("left")
		for i in get_node("/root/Mundo/ParedDerecha").get_children():
			i.get_node("Sprite").self_modulate = Color(1,1,1)
		for i in get_node("/root/Mundo/ParedIzquierda").get_children():
			i.get_node("Sprite").self_modulate = Color(1,0.3,0)
	elif Input.is_action_just_pressed("ui_up"):
		crear_laser(pos_izq)
		crear_laser(pos_der)
		for i in get_node("/root/Mundo/ParedDerecha").get_children():
			i.get_node("Sprite").self_modulate = Color(1,0,0)
		for i in get_node("/root/Mundo/ParedIzquierda").get_children():
			i.get_node("Sprite").self_modulate = Color(1,0,0)
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
	elif is_on_ceiling():
		$AnimatedSprite.self_modulate = Color(1,0,0)
	
	elif is_on_wall():
		mov.x = 0
	else:
		$AnimatedSprite.play("normal")
		#$AnimatedSprite.self_modulate = Color(1,1,1)
		
	move_and_slide(mov, ARRIBA)
	
func pos_canones():
	pos_izq = Vector2(self.position.x-24,self.position.y-12)
	get_node("Canones/izq").set_position(pos_izq)
	pos_der = Vector2(self.position.x+24,self.position.y-12)
	get_node("Canones/der").set_position(pos_der)
	pass
	
func crear_laser(pos):
	var bala = esc_bala.instance()
	bala.set_position(pos)
	get_node("/root").add_child(bala)
	pass
	
func crear_paredes():
	if int(self.position.y) % 3 == 0:
		var pared_der = esc_pared.instance()
		pared_der.set_position(Vector2(352,self.position.y-350))
		get_node("/root/Mundo/ParedDerecha").add_child(pared_der)
		var pared_izq = esc_pared.instance()
		pared_izq.set_position(Vector2(-352,self.position.y-350))
		get_node("/root/Mundo/ParedIzquierda").add_child(pared_izq)
	