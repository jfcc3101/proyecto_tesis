extends Node

const enemyCassette = preload("res://Escenas/EnemyCassette.tscn")
const enemyDisc = preload("res://Escenas/EnemyDisc.tscn")
const enemyPlayer = preload("res://Escenas/EnemyPlayer.tscn")
var parser = XMLParser.new()
var data =  Array()
var contEnemigos = [0,0,0,0,0,0,0,0,0,0,0,0]
#var posCamara = Vector2()
#var posJugador = Vector2()


func _ready():
	pass
	
func spawnCassette(posX):
	var posJugador = get_node("/root/Mundo/Jugador").position
	randomize()
	var enemy = enemyCassette.instance()
	var pos = Vector2()
	#pos.x = rand_range(posJugador.x-340,posJugador.x+330)
	pos.x = posX
	pos.y = posJugador.y-400
	enemy.position = pos
	get_node("Container").add_child(enemy)
	
func spawnDisc(posX):
	var posJugador = get_node("/root/Mundo/Jugador").position
	randomize()
	var enemy = enemyDisc.instance()
	var pos = Vector2()
	pos.x = posX
	#pos.x = rand_range(posJugador.x-340,posJugador.x+330)
	pos.y = posJugador.y-400
	enemy.position = pos
	get_node("Container").add_child(enemy)

func spawnMPlayer(posX):
	var posJugador = get_node("/root/Mundo/Jugador").position
	randomize()
	var enemy = enemyPlayer.instance()
	var pos = Vector2()
	pos.x = posX
	#pos.x = rand_range(posJugador.x-340,posJugador.x+330)
	pos.y = posJugador.y-400
	enemy.position = pos
	get_node("Container").add_child(enemy)
	
func spawnAleatorio(posX):
	
	if posX > -318 and posX < -265: contEnemigos[0] = contEnemigos[0]+1
	elif posX > -264 and posX < -212: contEnemigos[1] = contEnemigos[1]+1
	elif posX > -211 and posX < -159: contEnemigos[2] = contEnemigos[2]+1
	elif posX > -158 and posX < -106: contEnemigos[3] = contEnemigos[3]+1
	elif posX > -105 and posX < -53: contEnemigos[4] = contEnemigos[4]+1
	elif posX > -52 and posX < 0: contEnemigos[5] = contEnemigos[5]+1
	elif posX > 1 and posX < 53: contEnemigos[6] = contEnemigos[6]+1
	elif posX > 54 and posX < 106: contEnemigos[7] = contEnemigos[7]+1
	elif posX > 107 and posX < 159: contEnemigos[8] = contEnemigos[8]+1
	elif posX > 160 and posX < 212: contEnemigos[9] = contEnemigos[9]+1
	elif posX > 213 and posX < 265: contEnemigos[10] = contEnemigos[10]+1
	elif posX > 266 and posX < 318: contEnemigos[11] = contEnemigos[11]+1
	else: pass
	
	randomize()
	var enemigo = rand_range(0,3)
	if enemigo <= 1:
		spawnCassette(posX)
	elif enemigo <= 2:
		spawnDisc(posX)
	else:
		spawnMPlayer(posX)
	
func generateFromXML(ruta):
	parser.open(ruta)
	for j in range(1,17):
		var path = ""
		while (path == ""):
			parser.read()
			path = parser.get_node_data()
		data.append(path)
	data[1] = float(data[1])
	for i in range(2,len(data)-1):
		data[i] = data[i].replace("[","")
		data[i] = data[i].replace("]","")
		data[i] = data[i].rsplit(" ")
	for i in range(2,len(data)-1):
		data[i] = Array(data[i])
		for k in range(0,len(data[i])-1):
			data[i][k] = data[i][k].to_float()
			
	#print(data[1])
	pass
