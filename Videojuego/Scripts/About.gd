extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BotonVolver_pressed():
	get_tree().change_scene("res://Escenas/MainScreen.tscn")
	pass # Replace with function body.


func _on_BotonComoJugar_pressed():
	get_tree().change_scene("res://Escenas/How2Play.tscn")
	pass # Replace with function body.


func _on_BotonCreditos_pressed():
	get_tree().change_scene("res://Escenas/Credits.tscn")
	pass # Replace with function body.
