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

func _ready():
	
	#Reproducir la música
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audios/First Date.ogg")
	#player.play()
	
	set_process(true)
	add_to_group("nave")
	connect("area_entered",self,"on_area_enter")
	pass


func _physics_process(delta):
	#print($Camera2D.get_camera_position())
	pos_canones()
	var spawner = get_node("/root/Mundo/EnemySpawner")
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
	elif position.x <= -330 or position.x >= 330: mov.x *= -1
		
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
		$Particles2D.set_visible(false)
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
