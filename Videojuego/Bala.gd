extends Area2D

export var velocidad = Vector2()
const esc_flare = preload("res://Flare.tscn")


func _ready():
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