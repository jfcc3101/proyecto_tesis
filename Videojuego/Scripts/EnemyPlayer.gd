extends Area2D

const esc_explosion = preload("res://Escenas/Explosion.tscn")
export var mov = Vector2()
export var escudo = 3 setget set_escudo
var carril = 0
var en_juego = false
onready var spawner = get_node("/root/Mundo/EnemySpawner")
onready var timers = get_node("/root/Mundo/EnemySpawner/Timers")

func _ready():
	var lado = randi()%10+1
	set_process(true)
	carril_inicio()
	#Se define hacia qué costado se comienza a mover
	if lado < 5:
		self.mov.x = 50
	else:
		self.mov.x = -50
	add_to_group("enemigos")
	spawner.allowEnemigos[carril] = 0
	timers.get_child(carril).start()
	pass


func _process(delta):
	if position.x <= -330 or position.x >= 330: mov.x *= -1
	translate(mov * delta)
	if $VisibilityNotifier2D.is_on_screen():
		en_juego = true
		
	if not $VisibilityNotifier2D.is_on_screen() and en_juego:
		borrarDeLista()
		queue_free()
	
	$AnimatedSprite.play("default")

func crear_explosion():
	var explosion = esc_explosion.instance()
	explosion.set_position(get_position())
	get_node("/root/Mundo").add_child(explosion)

func set_escudo(valor):
	if is_queued_for_deletion(): return
	escudo = valor
	if escudo <= 0:
		get_node("/root/Mundo/Jugador").actualScore+=150
		borrarDeLista()
		crear_explosion()
		queue_free()

func on_area_enter(otro):
	#if otro.is_in_group("enemigos") and position.y<get_node("/root/Mundo/Jugador/Camera2D").get_camera_position().y-300:
		#borrarDeLista()
		#queue_free()
		pass

func borrarDeLista():
	spawner.contEnemigos[carril] = spawner.contEnemigos[carril]-1

func carril_inicio():
	if position.x > -318 and position.x < -265: carril = 0
	elif position.x > -264 and position.x < -212: carril = 1
	elif position.x > -211 and position.x < -159: carril = 2
	elif position.x > -158 and position.x < -106: carril = 3
	elif position.x > -105 and position.x < -53: carril = 4
	elif position.x > -52 and position.x < 0: carril = 5
	elif position.x > 1 and position.x < 53: carril = 6
	elif position.x > 54 and position.x < 106: carril = 7
	elif position.x > 107 and position.x < 159: carril = 8
	elif position.x > 160 and position.x < 212: carril = 9
	elif position.x > 213 and position.x < 265: carril = 10
	elif position.x > 266 and position.x < 318: carril = 11
	
