extends Area2D

const ARRIBA = Vector2(0,-1)
const ACELERACION = 15
const VELOCIDAD_MAX  = 300
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

func set_escudo(valor):
	escudo = valor
	if escudo <= 0: queue_free()