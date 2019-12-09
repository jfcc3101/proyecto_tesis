extends Area2D

export var velocidad = Vector2()
const esc_flare = preload("res://Escenas/Flare.tscn")


func _ready():
	connect("area_entered",self,"on_area_enter")
	set_process(true)
	crear_flare()
	yield(get_node("VisibilityNotifier2D"),"screen_exited")
	pass

func _process(delta):
	translate(velocidad*delta)
	pass

func crear_flare():
	var flare = esc_flare.instance()
	flare.set_position(get_position())
	#get_parent().add_child((flare)
	get_node("/root").add_child(flare)
	
func on_area_enter(otro):
	if otro.is_in_group("enemigos"):
		otro.escudo -= 1
		crear_flare()
		queue_free()