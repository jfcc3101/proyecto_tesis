extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/ItemList.add_item("Pista")
	$VBoxContainer/ItemList.add_item("Puntos")
	$VBoxContainer/ItemList.add_item("Jugador")
	for j in range(0,3):
		$VBoxContainer/ItemList.set_item_custom_bg_color(j, Color(0,0.3,0.3))
	for i in Global.hiScores.keys():
		$VBoxContainer/ItemList.add_item(i)
		$VBoxContainer/ItemList.add_item(str(Global.hiScores.get(i)[0]))
		$VBoxContainer/ItemList.add_item(str(Global.hiScores.get(i)[1]))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MenuButton_button_up():
	get_tree().change_scene("res://Escenas/MainScreen.tscn")
	queue_free()
	pass # Replace with function body.
