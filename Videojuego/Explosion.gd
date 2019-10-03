extends Sprite

func _ready():
	randomize()
	set_rotation(deg2rad(rand_range(0,360)))
	get_node("P_Flare").set_emitting(true)
	get_node("P_Smoke").set_emitting(true)
	
	get_node("AnimationPlayer").play("fade_out")
	yield(get_node("AnimationPlayer"),"animation_finished")
	queue_free()
	pass # Replace with function body.

