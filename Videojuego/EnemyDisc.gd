extends Area2D

const esc_explosion = preload("res://Explosion.tscn")
export var mov = Vector2()
export var escudo = 2 setget set_escudo

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
	pass
