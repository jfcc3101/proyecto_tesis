extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MenuOpciones/HBoxContainer/VolGen/VBoxContainerSliders/SliderGeneral.value = AudioServer.get_bus_volume_db(0)
	$MenuOpciones/HBoxContainer/VolGen/VBoxContainerSliders/SliderMusica.value = AudioServer.get_bus_volume_db(2)
	$MenuOpciones/HBoxContainer/VolGen/VBoxContainerSliders/SliderEfectos.value = AudioServer.get_bus_volume_db(1)
	pass


func _on_SliderMusica_value_changed(value):
	AudioServer.set_bus_volume_db(2,value)
	if AudioServer.get_bus_volume_db(2) == -30:
		AudioServer.set_bus_mute(2,true)
	else:
		AudioServer.set_bus_mute(2,false)


func _on_SliderEfectos_value_changed(value):
	AudioServer.set_bus_volume_db(1,value)
	if AudioServer.get_bus_volume_db(1) == -30:
		AudioServer.set_bus_mute(1,true)
	else:
		AudioServer.set_bus_mute(1,false)



func _on_SliderGeneral_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)
	if AudioServer.get_bus_volume_db(0) == -30:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)


func _on_Botonvolver_pressed():
	get_tree().change_scene("res://Escenas/MainScreen.tscn")
	pass # Replace with function body.
