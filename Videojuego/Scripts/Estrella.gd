extends AnimatedSprite



# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("default")
	pass # Replace with function body.


func _process(delta):
	var posCamara = get_node("/root/Mundo/Jugador/Camera2D").get_camera_position()
	if position.y>posCamara.y+100:
		#print("pos_estrella: "+str(position.y)+"pos_cámara: "+str(posCamara.y))
		queue_free()
	pass
