extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasHUD/LabelGameOver.set_visible(false)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("/root/Mundo/Jugador").escudo ==2:
		get_node("CanvasHUD/Vida3").set_visible(false)
	if get_node("/root/Mundo/Jugador").escudo ==1:
		get_node("CanvasHUD/Vida2").set_visible(false)
	if get_node("/root/Mundo/Jugador").escudo ==0:
		get_node("CanvasHUD/Vida1").set_visible(false)
		$CanvasHUD/LabelGameOver.set_visible(true)
	pass
