extends Sprite

func _ready():
	get_node("AnimationPlayer").play("flare")
	yield(get_node("AnimationPlayer"),"animation_finished")
	queue_free()
	pass 
