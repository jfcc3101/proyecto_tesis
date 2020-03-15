extends Area2D

const ACELERACION = 15
const VELOCIDAD_MAX  = 300
export var mov = Vector2()
var pos_izq = Vector2()
var pos_der = Vector2()
const esc_bala = preload("res://Escenas/Bala.tscn")
const esc_pared = preload("res://Escenas/Pared.tscn")
const esc_explosion = preload("res://Escenas/Explosion.tscn")
var escudo = 3 setget set_escudo
export(String,FILE,"*.tscn") var escena_gameover
onready var spawner = get_node("/root/Mundo/EnemySpawner")
onready var timer = get_node("TimerVel")
onready var player = AudioStreamPlayer.new()
var contArchivo = 0

func _ready():
	
	#Reproducir la música
	#var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audios/First Date.ogg")
	player.play()
	player.autoplay = false
	
	timer.set_wait_time(0.0227272727272727)
	timer.start()
	
	set_process(true)
	add_to_group("nave")
	connect("area_entered",self,"on_area_enter")
	
	spawner.generateFromXML("res://XML/First Date.xml")
	get_node("Camera2D/HUD/CanvasHUD/LabelNombrePista").set_text(get_node("/root/Mundo/EnemySpawner").data[0])
	pass


func _physics_process(delta):
	#print($Camera2D.get_camera_position())
		
	pos_canones()
	
	translate(mov*delta)
	#mov.y = -110
	if Input.is_action_pressed("ui_right"):
		if position.x < -330 or position.x > 330: mov.x *= -1
		else: mov.x = min(mov.x+ACELERACION,VELOCIDAD_MAX)
		$AnimatedSprite.play("right")
		get_node("Camera2D/HUD/CanvasHUD/ParedIzq").self_modulate = Color(1,1,1)
		get_node("Camera2D/HUD/CanvasHUD/ParedDer").self_modulate = Color(1,0.3,0)
		if Input.is_action_just_pressed("ui_up"):
			crear_laser(pos_izq)
			crear_laser(pos_der)
			get_node("Camera2D/HUD/CanvasHUD/ParedIzq").self_modulate = Color(1,0,0)
			get_node("Camera2D/HUD/CanvasHUD/ParedDer").self_modulate = Color(1,0,0)
		#$AnimatedSprite.self_modulate = Color(0.2,0.3,0.1)
	elif Input.is_action_pressed("ui_left"):
		if position.x < -330 or position.x > 330: mov.x *= -1
		else: mov.x = max(mov.x-ACELERACION,-VELOCIDAD_MAX)
		$AnimatedSprite.play("left")
		get_node("Camera2D/HUD/CanvasHUD/ParedIzq").self_modulate = Color(1,0.3,0)
		get_node("Camera2D/HUD/CanvasHUD/ParedDer").self_modulate = Color(1,1,1)
		if Input.is_action_just_pressed("ui_up"):
			crear_laser(pos_izq)
			crear_laser(pos_der)
			get_node("Camera2D/HUD/CanvasHUD/ParedIzq").self_modulate = Color(1,0,0)
			get_node("Camera2D/HUD/CanvasHUD/ParedDer").self_modulate = Color(1,0,0)
	elif Input.is_action_just_pressed("ui_up"):
		crear_laser(pos_izq)
		crear_laser(pos_der)
		get_node("Camera2D/HUD/CanvasHUD/ParedIzq").self_modulate = Color(1,0,0)
		get_node("Camera2D/HUD/CanvasHUD/ParedDer").self_modulate = Color(1,0,0)
		pass
	elif position.x <= -330 or position.x >= 330: mov.x *= -1
	else:
		$AnimatedSprite.play("normal")
		#$AnimatedSprite.self_modulate = Color(1,1,1)
		
	"""elif Input.is_action_just_pressed("ui_down"):
		randomize()
		var enemigo = rand_range(0,3)
		if enemigo <= 1:
			spawner.spawnCassette()
		elif enemigo <= 2:
			spawner.spawnDisc()
		else:
			spawner.spawnMPlayer()
		pass
		#mov.y = min(mov.y+ACELERACION,VELOCIDAD_MAX)"""

		
	
		
	
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
		$Particles2D.set_visible(false)
		player.stop()
		timer.stop()
		self.mov.y = 0
		#get_tree().change_scene(escena_gameover)
		#queue_free()
	pass
	
func crear_explosion():
	var explosion = esc_explosion.instance()
	explosion.set_position(get_position())
	get_node("/root/Mundo").add_child(explosion)

func on_area_enter(otro):
	if otro.is_in_group("enemigos"):
		crear_explosion()
		set_escudo(escudo-1)
		#otro.crear_flare()
		print("vidas: " + str(escudo))
		
	elif otro.is_in_group("paredes"):
		mov.x *= -1


func TimerVelTimeout():
	if contArchivo == len(get_node("/root/Mundo/EnemySpawner").data[2])-1:
		mov.y = 0
		timer.stop()
		player.stop()
	mov.y = -get_node("/root/Mundo/EnemySpawner").data[2][contArchivo]
	#print(get_node("/root/Mundo/EnemySpawner").data[2][len(get_node("/root/Mundo/EnemySpawner").data[2])-1])
	#print(get_node("/root/Mundo/EnemySpawner").data[2][contArchivo])
	var ordenados = []
	#ordenados[0] = Vector2(get_node("/root/Mundo/EnemySpawner").data[3][contArchivo], 3)
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
	for i in range(rand_range(2,7)):
		if get_tree().get_nodes_in_group("enemigos").size() < 12:
			if ordenados[i][1] == 0 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(-318,-281))
			elif ordenados[i][1] == 1 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(-248,-228))
			elif ordenados[i][1] == 2 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(-195,-175))
			elif ordenados[i][1] == 3 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(-142,-122))
			elif ordenados[i][1] == 4 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(-89,-69))
			elif ordenados[i][1] == 5 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(-36,-16))
			elif ordenados[i][1] == 6 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(17,37))
			elif ordenados[i][1] == 7 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(70,90))
			elif ordenados[i][1] == 8 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(123,143))
			elif ordenados[i][1] == 9 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(176,196))
			elif ordenados[i][1] == 10 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(229,249))
			elif ordenados[i][1] == 11 and ordenados[i][0]>0.7:
				randomize()
				spawner.spawnAleatorio(rand_range(282,318))
		pass
		
	
	contArchivo += 1
	pass # Replace with function body.
