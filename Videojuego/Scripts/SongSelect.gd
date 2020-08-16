extends Control


var canciones = list_files_in_directory("Audios")


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/BotonEmpezar.disabled = true
	for i in canciones:
		print(i)
		$VBoxContainer/Tracklist.add_item(i)
	#$AnimatedSprite.set_visible(false)
	#$Analizando.set_visible(false)
	pass # Replace with function body.

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with(".mp3"):
			files.append(file)

	dir.list_dir_end()

	return files
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $VBoxContainer/Tracklist.is_anything_selected():
		pass
	

static func write_file(file_name, string):
	var file = File.new()
	file.open(file_name, File.WRITE)
	file.store_string(string)
	file.close()


func _on_BotonEmpezar_pressed():
	$WindowDialog.show()
	#$VBoxContainer/HBoxContainer/BotonEmpezar.disabled = true
	#$VBoxContainer/HBoxContainer/BotonVolver.disabled = true
	if $VBoxContainer/Tracklist.is_anything_selected():
		print(canciones[$VBoxContainer/Tracklist.get_selected_items()[0]])
		var mp3 = canciones[$VBoxContainer/Tracklist.get_selected_items()[0]]
		Global.actual = mp3
		var ogg = canciones[$VBoxContainer/Tracklist.get_selected_items()[0]].replace(".mp3",".ogg")
		var xml = canciones[$VBoxContainer/Tracklist.get_selected_items()[0]].replace(".mp3",".xml")
		var checkogg = File.new()
		Global.actualogg = "Audios/"+ogg
		var doOggExists = checkogg.file_exists(Global.actualogg)
		
		var checkxml = File.new()
		Global.actualxml = "Audios/"+xml
		var doXmlExists = checkxml.file_exists(Global.actualxml)
		
		if not doOggExists or not doXmlExists:
			
			#Se pone el nombre de la cancion en el .txt y ejecuta .exe con el análisis
			print("Hay que hacer análisis")
			write_file("toAnalyze.txt","Audios\\"+mp3)
			OS.execute("feature_ext.exe",[],true)
			print("Análisis finalizado")
			
			get_tree().change_scene("res://Escenas/Mundo.tscn")
		else:
			get_tree().change_scene("res://Escenas/Mundo.tscn")


func _on_BotonVolver_pressed():
	get_tree().change_scene("res://Escenas/MainScreen.tscn")
	pass # Replace with function body.


func _on_Button_pressed():
	$WindowDialog.show()
	pass # Replace with function body.


func _on_Tracklist_item_selected(index):
	$VBoxContainer/HBoxContainer/BotonEmpezar.disabled = false
	pass # Replace with function body.
	


func _on_WindowDialog_about_to_show():
	$VBoxContainer/HBoxContainer/BotonEmpezar.disabled = true
	$VBoxContainer/HBoxContainer/BotonVolver.disabled = true
	pass # Replace with function body.
