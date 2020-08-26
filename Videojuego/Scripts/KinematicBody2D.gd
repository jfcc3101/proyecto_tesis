extends Area2D

const ACELERACION = 15
const VELOCIDAD_MAX  = 250
const ENEMIGOS_MAX_CARRIL = 1
export var mov = Vector2()
var pos_izq = Vector2()
var pos_der = Vector2()
const esc_bala = preload("res://Escenas/Bala.tscn")
const esc_explosion = preload("res://Escenas/Explosion.tscn")
const esc_estrella = preload("res://Escenas/Estrella.tscn")
var escudo = 3 setget set_escudo
onready var spawner = get_node("/root/Mundo/EnemySpawner")
onready var timer = get_node("TimerVel")
onready var timersafe = get_node("TimerSafe")
onready var timerfin = get_node("TimerFinal")
onready var player = AudioStreamPlayer.new()
var POTENCIA_MIN_AUDIO = 0.5
var tempoM = 0.0
var contArchivo = 0
var actualScore = 0

func _ready():
	#Reproducir la música
	var snd_file=File.new()
	snd_file.open(Global.actualogg, File.READ)
	var stream=AudioStreamOGGVorbis.new()
	stream.data=snd_file.get_buffer(snd_file.get_len())
	player.stream=stream
	snd_file.close()
	self.add_child(player)
	#Asignar el BUS
	player.set_bus("Music")
	player.play()
	player.autoplay = false
	
	#Establecer el tiempo de espera que hay entre dato y dato del archivo xml
	timer.set_wait_time(0.0227272727272727)
	timer.start()
	#Establecer tiempo de espera cuando el jugador se estrella y se desactiva su area de colisión
	timersafe.set_wait_time(1.8)
	timersafe.set_one_shot(true)
	
	set_process(true)
	add_to_group("nave")
	connect("area_entered",self,"on_area_enter")
	
	#Genera el arreglo con los datos leídos a partir del XML
	spawner.generateFromXML(Global.actualxml)
	spawner.calcular_media_chroma()
	print(Global.promedios)
	print(Global.promedio)
	POTENCIA_MIN_AUDIO = Global.promedio
	get_node("Camera2D/HUD/CanvasHUD/LabelNombrePista").set_text(Global.actual)
	
	pass


func _physics_process(delta):
		
	pos_canones()
	
	mov.x *= 0.99
	
	translate(mov*delta)
	#mov.y = -110
	if Input.is_action_pressed("ui_right"):
		if position.x < -330 or position.x > 330:
			mov.x *= -1
			if position.x < -330:
				position.x = -330
			elif position.x > 330:
				position.x = 330
		else: mov.x = min(mov.x+ACELERACION,VELOCIDAD_MAX)
		$AnimatedSprite.play("right")
		if Input.is_action_just_pressed("ui_accept"):
			crear_laser(pos_izq)
			crear_laser(pos_der)
	elif Input.is_action_pressed("ui_left"):
		if position.x < -330 or position.x > 330:
			mov.x *= -1
			if position.x < -330:
				position.x = -330
			elif position.x > 330:
				position.x = 330
		else: mov.x = max(mov.x-ACELERACION,-VELOCIDAD_MAX)
		$AnimatedSprite.play("left")
		if Input.is_action_just_pressed("ui_accept"):
			crear_laser(pos_izq)
			crear_laser(pos_der)
	elif Input.is_action_just_pressed("ui_accept"):
		crear_laser(pos_izq)
		crear_laser(pos_der)
		pass
	elif position.x <= -330 or position.x >= 330:
			mov.x *= -1
			if position.x < -330:
				position.x = -330
			elif position.x > 330:
				position.x = 330
	else:
		$AnimatedSprite.play("normal")
		#$AnimatedSprite.self_modulate = Color(1,1,1)

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
	

func set_escudo(valor):
	if is_queued_for_deletion(): return
	escudo = valor
	if escudo <= 0:
		for i in get_node("/root/Mundo/EnemySpawner/Container").get_children():
			get_node("/root/Mundo/EnemySpawner/Container").remove_child(i)
		$AnimatedSprite.set_visible(false)
		player.stop()
		timer.stop()
		self.mov.y = 0
	pass
	
func crear_explosion():
	var explosion = esc_explosion.instance()
	explosion.set_position(get_position())
	get_node("/root/Mundo").add_child(explosion)

func on_area_enter(otro):
	if otro.is_in_group("enemigos"):
		if timersafe.is_stopped():
			crear_explosion()
			set_escudo(escudo-1)
			get_node("AnimatedSprite/AnimationSafe").play("safe")
			timersafe.start()
			print("vidas: " + str(escudo))
		

func crear_estrella():
	var estrella = esc_estrella.instance()
	randomize()
	var posx = rand_range(-340,340)
	var pos_est = Vector2()
	pos_est.x = posx
	pos_est.y = get_position().y-400
	estrella.set_position(pos_est)
	get_node("Camera2D/HUD").add_child(estrella)
	
	

func TimerVelTimeout():
	var tempoM = float(spawner.data[1])
	#Se crean estrellas de manera aleatoria
	randomize()
	var randomEstrella = rand_range(0,100)
	if(randomEstrella < 30):
		crear_estrella()
	
	if contArchivo == len(spawner.data[2])-2:
		#Si se llega al final del archivo,
		#aparece el mensaje de final y los botones
		mov.y = 0
		timer.stop()
		timerfin.start()
	mov.y = -get_node("/root/Mundo/EnemySpawner").data[2][contArchivo]
	spawner.actualizar_tiempos(-mov.y)
	if spawner.data[2][contArchivo] - tempoM < -10:
		var difNeg = -int((spawner.data[2][contArchivo] - tempoM)/10)
		#print(difNeg)
		$ParallaxBackground/ParallaxLayer/Fondo.self_modulate = Color(0,difNeg*0.1,0,1)
	elif spawner.data[2][contArchivo] - tempoM > 10:
		var difPos = int((spawner.data[2][contArchivo] - tempoM)/20)
		#print(String(spawner.data[2][contArchivo] - tempoM))
		$ParallaxBackground/ParallaxLayer/Fondo.self_modulate = Color(difPos*0.1,0,0,1)
	else:
		$ParallaxBackground/ParallaxLayer/Fondo.self_modulate = Color(0,0,0,1)
	#print(get_node("/root/Mundo/EnemySpawner").data[2][len(get_node("/root/Mundo/EnemySpawner").data[2])-1])
	#print(get_node("/root/Mundo/EnemySpawner").data[2][contArchivo])
	var ordenados = []
	#ordenados[0] = Vector2(get_node("/root/Mundo/EnemySpawner").data[3][contArchivo], 3)
	#Ordenamiento de las intensidades de las notas
	for i in range(12):
		i=int(i)
		var actual = get_node("/root/Mundo/EnemySpawner").data[i+3][contArchivo]
		var j = i
		while j > 0 and ordenados[j-1][0] > actual:
			ordenados.insert(j,ordenados[j-1])
			j-=1
		var nuevo = []
		nuevo.append(actual)
		nuevo.append(i)
		ordenados.insert(j,nuevo)
		pass
		
	
	randomize()
	#for i in range(rand_range(2,7)):
	for i in range(3):
		#Crea entre 3 y 7 enemigos  a partir de la lista ordenada
		if get_tree().get_nodes_in_group("enemigos").size() < 12:
			if ordenados[i][1] == 0 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[0] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(-318,-281))
			elif ordenados[i][1] == 1 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[1] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(-248,-228))
			elif ordenados[i][1] == 2 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[2] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(-195,-175))
			elif ordenados[i][1] == 3 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[3] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(-142,-122))
			elif ordenados[i][1] == 4 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[4] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(-89,-69))
			elif ordenados[i][1] == 5 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[5] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(-36,-16))
			elif ordenados[i][1] == 6 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[6] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(17,37))
			elif ordenados[i][1] == 7 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[7] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(70,90))
			elif ordenados[i][1] == 8 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[8] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(123,143))
			elif ordenados[i][1] == 9 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[9] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(176,196))
			elif ordenados[i][1] == 10 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[10] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(229,249))
			elif ordenados[i][1] == 11 and ordenados[i][0]>POTENCIA_MIN_AUDIO and spawner.contEnemigos[11] < ENEMIGOS_MAX_CARRIL:
				randomize()
				spawner.spawnAleatorio(rand_range(282,318))
			else:
				pass
		pass
		
	#Aumenta el contador que recorre los datos del XML de la canción
	contArchivo += 1
	pass # Replace with function body.


func _on_TimerSafe_timeout():
	print("Colisión activada")
	pass # Replace with function body.
	
func guardar_record(jugador):
	"""
	Se guarda el record dentro del archivo records.json
	De ser necesario se reemplaza el record antiguo con el nuevo
	"""
	if self.escudo>0:
		var ruta = "records.json"
		
		if Global.hiScores.has(Global.actual):
			Global.hiScores.erase(Global.actual)
		Global.hiScores[Global.actual] = [actualScore,jugador]
		
		var file = File.new()
		if file.open(ruta, File.WRITE) != 0:
			print("Error opening file")
			return
			
		#Guarda el diccionario en el archivo json
		file.store_line(to_json(Global.hiScores))
		file.close()
		pass
	pass


func _on_TimerFinal_timeout():
	"""
	Espera un tiempo a que termine la última parte de la canción que
	se cortaría debido a un corto delay que hay al leer los datos
	"""
	if escudo > 0:
		$Camera2D/HUD/CanvasHUD/LabelFInPartida.set_visible(true)
		$Camera2D/HUD/CanvasHUD/LabelFInPartida/LabelScoreFin.set_text("TU PUNTAJE: " + str(actualScore))
		var puntaje = Global.hiScores.get(Global.actual)
		#print("Actual: ", Global.actual, " puntaje: ", puntaje[0])
		if Global.hiScores.has(Global.actual):
			if Global.hiScores.get(Global.actual)[0] >= actualScore:
				$Camera2D/HUD/CanvasHUD/LabelFInPartida/ScoreNombre.set_visible(false)
				$Camera2D/HUD/CanvasHUD/LabelFInPartida/BotonEnter.set_visible(false)
				$Camera2D/HUD/CanvasHUD/LabelFInPartida/LabelJugador.set_visible(false)
				$Camera2D/HUD/CanvasHUD/BotonRetry.set_visible(true)
				$Camera2D/HUD/CanvasHUD/BotonRetry.set_disabled(false)
				$Camera2D/HUD/CanvasHUD/BotonMenu.set_visible(true)
				$Camera2D/HUD/CanvasHUD/BotonMenu.set_disabled(false)
	pass # Replace with function body.
