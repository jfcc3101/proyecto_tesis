extends Node

const enemy_cassette = preload("res://EnemyCassette.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()
	pass # Replace with function body.
	
func spawn():
	var enemy = enemy_cassette.instance()
	add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
