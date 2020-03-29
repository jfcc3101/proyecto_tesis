extends Area2D

const esc_explosion = preload("res://Escenas/Explosion.tscn")
export var mov = Vector2()
export var escudo = 2 setget set_escudo
onready var spawner = get_node("/root/Mundo/EnemySpawner")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	add_to_group("enemigos")
	pass # Replace with function body.


func _process(delta):
	var posCamara = get_node("/root/Mundo/Jugador/Camera2D").get_camera_position()
	#print(posCamara)
	translate(mov * delta)
	#mov.y = -100
	$AnimatedSprite.play("default")
	if position.y >= posCamara.y+100:
		borrarDeLista()
		queue_free()
		
func crear_explosion():
	var explosion = esc_explosion.instance()
	explosion.set_position(get_position())
	get_node("/root/Mundo").add_child(explosion)

func set_escudo(valor):
	if is_queued_for_deletion(): return
	escudo = valor
	if escudo <= 0:
		borrarDeLista()
		crear_explosion()
		queue_free()
	pass
	
func borrarDeLista():
	if position.x > -318 and position.x < -265: spawner.contEnemigos[0] = spawner.contEnemigos[0]-1
	elif position.x > -264 and position.x < -212: spawner.contEnemigos[1] = spawner.contEnemigos[1]-1
	elif position.x > -211 and position.x < -159: spawner.contEnemigos[2] = spawner.contEnemigos[2]-1
	elif position.x > -158 and position.x < -106: spawner.contEnemigos[3] = spawner.contEnemigos[3]-1
	elif position.x > -105 and position.x < -53: spawner.contEnemigos[4] = spawner.contEnemigos[4]-1
	elif position.x > -52 and position.x < 0: spawner.contEnemigos[5] = spawner.contEnemigos[5]-1
	elif position.x > 1 and position.x < 53: spawner.contEnemigos[6] = spawner.contEnemigos[6]-1
	elif position.x > 54 and position.x < 106: spawner.contEnemigos[7] = spawner.contEnemigos[7]-1
	elif position.x > 107 and position.x < 159: spawner.contEnemigos[8] = spawner.contEnemigos[8]-1
	elif position.x > 160 and position.x < 212: spawner.contEnemigos[9] = spawner.contEnemigos[9]-1
	elif position.x > 213 and position.x < 265: spawner.contEnemigos[10] = spawner.contEnemigos[10]-1
	elif position.x > 266 and position.x < 318: spawner.contEnemigos[11] = spawner.contEnemigos[11]-1
