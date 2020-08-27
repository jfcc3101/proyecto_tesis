extends Node

const enemyCassette = preload("res://Escenas/EnemyCassette.tscn")
const enemyDisc = preload("res://Escenas/EnemyDisc.tscn")
const enemyPlayer = preload("res://Escenas/EnemyPlayer.tscn")
var parser = XMLParser.new()
var data =  Array()
var contEnemigos = [0,0,0,0,0,0,0,0,0,0,0,0]
var allowEnemigos = [1,1,1,1,1,1,1,1,1,1,1,1]
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
	
	if posX > -318 and posX < -265 and allowEnemigos[0] == 1:
		contEnemigos[0] = contEnemigos[0]+1
		allowEnemigos[0] = 0
	elif posX > -264 and posX < -212 and allowEnemigos[1] == 1:
		contEnemigos[1] = contEnemigos[1]+1
		allowEnemigos[1] = 0
	elif posX > -211 and posX < -159 and allowEnemigos[2] == 1:
		contEnemigos[2] = contEnemigos[2]+1
		allowEnemigos[2] = 0
	elif posX > -158 and posX < -106 and allowEnemigos[3] == 1:
		contEnemigos[3] = contEnemigos[3]+1
		allowEnemigos[3] = 0
	elif posX > -105 and posX < -53 and allowEnemigos[4] == 1:
		contEnemigos[4] = contEnemigos[4]+1
		allowEnemigos[4] = 0
	elif posX > -52 and posX < 0 and allowEnemigos[5] == 1:
		contEnemigos[5] = contEnemigos[5]+1
		allowEnemigos[5] = 0
	elif posX > 1 and posX < 53 and allowEnemigos[6] == 1:
		contEnemigos[6] = contEnemigos[6]+1
		allowEnemigos[6] = 0
	elif posX > 54 and posX < 106 and allowEnemigos[7] == 1:
		contEnemigos[7] = contEnemigos[7]+1
		allowEnemigos[7] = 0
	elif posX > 107 and posX < 159 and allowEnemigos[8] == 1:
		contEnemigos[8] = contEnemigos[8]+1
		allowEnemigos[8] = 0
	elif posX > 160 and posX < 212 and allowEnemigos[9] == 1:
		contEnemigos[9] = contEnemigos[9]+1
		allowEnemigos[9] = 0
	elif posX > 213 and posX < 265 and allowEnemigos[10] == 1:
		contEnemigos[10] = contEnemigos[10]+1
		allowEnemigos[10] = 0
	elif posX > 266 and posX < 318 and allowEnemigos[11] == 1:
		contEnemigos[11] = contEnemigos[11]+1
		allowEnemigos[11] = 0
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

"""Cada uno de los timers levanta una
bandera después de pasado un tiempo
para poder crear nuevos enemigos"""

func _on_TimerA_timeout():
	allowEnemigos[2] = 1
	pass # Replace with function body.

func _on_TimerAsus_timeout():
	allowEnemigos[1] = 1
	pass # Replace with function body.

func _on_TimerB_timeout():
	allowEnemigos[0] = 1
	pass # Replace with function body.

func _on_TimerC_timeout():
	allowEnemigos[11] = 1
	pass # Replace with function body.

func _on_TimerCsus_timeout():
	allowEnemigos[10] = 1
	pass # Replace with function body.

func _on_TimerD_timeout():
	allowEnemigos[9] = 1
	pass # Replace with function body.

func _on_TimerDsus_timeout():
	allowEnemigos[8] = 1
	pass # Replace with function body.

func _on_TimerE_timeout():
	allowEnemigos[7] = 1
	pass # Replace with function body.

func _on_TimerF_timeout():
	allowEnemigos[6] = 1
	pass # Replace with function body.

func _on_TimerFsus_timeout():
	allowEnemigos[5] = 1
	pass # Replace with function body.

func _on_TimerG_timeout():
	allowEnemigos[4] = 1
	pass # Replace with function body.

func _on_TimerGsus_timeout():
	allowEnemigos[3] = 1
	pass # Replace with function body.

"""Cuando se acaba el cooldown de
 60/(2*bpm) segundos del carril correspondiente
 se permite la creación de un nuevo enemigo"""

func actualizar_tiempos(bpm):
	var cooldown = 60/(2*bpm)
	for i in $Timers.get_children():
		i.set_wait_time(cooldown)
	pass
	
func calcular_media_chroma():
#Función para calcular la media de los datos del chroma del total de la canción.
	var promedios = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
	for i in range(12):
		i = int(i)
		for j in range(len(data[i+3])):
			j=int(j)
			promedios[i] += float(data[i+3][j])
		promedios[i] = promedios[i]/data[i+3].size()
	Global.promedios = promedios
	for i in promedios:
		Global.promedio +=i
	Global.promedio = Global.promedio/12
	pass
