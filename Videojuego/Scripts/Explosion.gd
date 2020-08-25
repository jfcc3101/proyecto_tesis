extends Sprite

func _ready():
	randomize()
	set_rotation(deg2rad(rand_range(0,360)))
	get_node("P_Flare").set_emitting(true)
	get_node("P_Smoke").set_emitting(true)
	
	var fxplayer = AudioStreamPlayer.new()
	fxplayer.set_bus("SFX")
	self.add_child(fxplayer)
	fxplayer.set_volume_db(1)
	fxplayer.stream = load("res://AudioFX/Explosion.wav")
	fxplayer.autoplay = false
	fxplayer.play()
	
	get_node("AnimationPlayer").play("fade_out")
	yield(get_node("AnimationPlayer"),"animation_finished")
	queue_free()
	pass # Replace with function body.

