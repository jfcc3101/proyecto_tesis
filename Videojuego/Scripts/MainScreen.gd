extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	leer_scores()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_BotonNP_pressed():
	get_tree().change_scene("res://Escenas/SongSelect.tscn")
	queue_free()
	pass # Replace with function body.


func _on_BotonOpciones_pressed():
	get_tree().change_scene("res://Escenas/OptionMenu.tscn")
	queue_free()
	pass # Replace with function body.


func _on_BotonAcercaDe_pressed():
	get_tree().change_scene("res://Escenas/About.tscn")
	queue_free()
	pass # Replace with function body.
	
func leer_scores():
	#print("leyendo records")
	var file = File.new()
	if not file.file_exists("records.json"):
		print("No file saved!")
		return

	if file.open("records.json", File.READ) != 0:
		print("Error opening file")
		return

	Global.hiScores = parse_json(file.get_line())
	#print("archivo leído")
	#print(Global.hiScores)
	file.close()
	pass


func _on_BotonScores_button_up():
	get_tree().change_scene("res://Escenas/Scores.tscn")
	queue_free()
	pass # Replace with function body.
