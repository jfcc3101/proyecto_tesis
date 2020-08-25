extends Area2D

export var velocidad = Vector2()
const esc_flare = preload("res://Escenas/Flare.tscn")
#onready var fxplayer = AudioStreamPlayer.new()


func _ready():
	var fxplayer = AudioStreamPlayer.new()
	fxplayer.set_bus("SFX")
	self.add_child(fxplayer)
	fxplayer.set_volume_db(1)
	fxplayer.stream = load("res://AudioFX/Shot2.wav")
	fxplayer.autoplay = false
	fxplayer.play()
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
		#get_node("/root/Mundo/Jugador").actualScore+=50
		crear_flare()
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
