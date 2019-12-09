extends Area2D

const esc_explosion = preload("res://Escenas/Explosion.tscn")
export var mov = Vector2()
export var escudo = 3 setget set_escudo

func _ready():
	set_process(true)
	add_to_group("enemigos")
	pass


func _process(delta):
	var posCamara = get_node("/root/Mundo/Jugador/Camera2D").get_camera_position()
	translate(mov * delta)
	#mov.y = -100
	$AnimatedSprite.play("default")
	if position.y >= posCamara.y+100:
		queue_free()

func crear_explosion():
	var explosion = esc_explosion.instance()
	explosion.set_position(get_position())
	get_node("/root/Mundo").add_child(explosion)

func set_escudo(valor):
	if is_queued_for_deletion(): return
	escudo = valor
	if escudo <= 0:
		crear_explosion()
		queue_free()