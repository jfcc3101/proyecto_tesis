extends Node

const enemyCassette = preload("res://EnemyCassette.tscn")
const enemyDisc = preload("res://EnemyDisc.tscn")
const enemyPlayer = preload("res://EnemyPlayer.tscn")
var posCamara = Vector2()
var posJugador = Vector2()


func _ready():
	#print(get_path())
	
	#var posCamara = get_node("/root/Mundo/Jugador/Camera2D").get_camera_position()
	randomize()
	var enemigo = rand_range(0,3)
	if enemigo <= 1:
		spawnCassette()
	elif enemigo <= 2:
		spawnDisc()
	else:
		spawnMPlayer()
	

	
func spawnCassette():
	var posJugador = get_node("/root/Mundo/Jugador").position
	randomize()
	var enemy = enemyCassette.instance()
	var pos = Vector2()
	pos.x = rand_range(posJugador.x-340,posJugador.x+330)
	pos.y = posJugador.y-600
	enemy.position = pos
	get_node("Container").add_child(enemy)
	
func spawnDisc():
	var posJugador = get_node("/root/Mundo/Jugador").position
	randomize()
	var enemy = enemyDisc.instance()
	var pos = Vector2()
	pos.x = rand_range(posJugador.x-340,posJugador.x+330)
	pos.y = posJugador.y-600
	enemy.position = pos
	get_node("Container").add_child(enemy)

func spawnMPlayer():
	var posJugador = get_node("/root/Mundo/Jugador").position
	randomize()
	var enemy = enemyPlayer.instance()
	var pos = Vector2()
	pos.x = rand_range(posJugador.x-340,posJugador.x+330)
	pos.y = posJugador.y-600
	enemy.position = pos
	get_node("Container").add_child(enemy)
