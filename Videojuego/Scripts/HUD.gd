extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasHUD/LabelInicio.set_visible(true)
	$CanvasHUD/LabelInicio/AnimacionInicio.play("Start")
	$CanvasHUD/LabelGameOver.set_visible(false)
	$CanvasHUD/BotonRetry.set_visible(false)
	$CanvasHUD/BotonRetry.set_disabled(true)
	$CanvasHUD/BotonMenu.set_visible(false)
	$CanvasHUD/BotonMenu.set_disabled(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("/root/Mundo/Jugador").escudo ==2:
		get_node("CanvasHUD/Vida3").set_visible(false)
	if get_node("/root/Mundo/Jugador").escudo ==1:
		get_node("CanvasHUD/Vida3").set_visible(false)
		get_node("CanvasHUD/Vida2").set_visible(false)
	if get_node("/root/Mundo/Jugador").escudo ==0:
		get_node("CanvasHUD/Vida3").set_visible(false)
		get_node("CanvasHUD/Vida2").set_visible(false)
		get_node("CanvasHUD/Vida1").set_visible(false)
		$CanvasHUD/LabelGameOver.set_visible(true)
		$CanvasHUD/BotonRetry.set_visible(true)
		$CanvasHUD/BotonRetry.set_disabled(false)
		$CanvasHUD/BotonMenu.set_visible(true)
		$CanvasHUD/BotonMenu.set_disabled(false)
	if $CanvasHUD/BotonMenu.pressed:
		get_tree().change_scene("res://Escenas/MainScreen.tscn")
	if $CanvasHUD/BotonRetry.pressed:
		get_tree().change_scene("res://Escenas/Mundo.tscn")
	get_node("CanvasHUD/LabelScore").set_text("SCORE:"+str(get_node("/root/Mundo/Jugador").actualScore))
	pass


func _on_ScoreNombre_text_changed():
	if $CanvasHUD/LabelFInPartida/ScoreNombre.get_text().length() >= 4:
		$CanvasHUD/LabelFInPartida/ScoreNombre.readonly = true
	pass # Replace with function body.

func _input(event):
	if $CanvasHUD/LabelFInPartida/ScoreNombre.readonly == true and Input.is_action_just_pressed("backspace"):
		$CanvasHUD/LabelFInPartida/ScoreNombre.readonly = false


func _on_BotonEnter_button_up():
	if $CanvasHUD/LabelFInPartida/ScoreNombre.get_text() != "":
		get_node("/root/Mundo/Jugador").guardar_record($CanvasHUD/LabelFInPartida/ScoreNombre.get_text())
		$CanvasHUD/LabelFInPartida/ScoreNombre.set_visible(false)
		$CanvasHUD/LabelFInPartida/BotonEnter.set_visible(false)
		$CanvasHUD/LabelFInPartida/LabelJugador.set_visible(false)
		$CanvasHUD/BotonRetry.set_visible(true)
		$CanvasHUD/BotonRetry.set_disabled(false)
		$CanvasHUD/BotonMenu.set_visible(true)
		$CanvasHUD/BotonMenu.set_disabled(false)
	else:
		OS.alert("Por favor ingresa un nombre para guardar tu record", "Error al guardar record")
	pass # Replace with function body.
