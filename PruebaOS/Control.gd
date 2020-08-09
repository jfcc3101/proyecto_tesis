extends Control

#var parser = XMLParser.new()
#var cancion = Array()
# Called when the node enters the scene tree for the first time.
#var args = ["feature_ext.py"]
var args = ["analyze('A.mp3')"]
func _ready():
	
	#print(parser.open("res://saves/actual.xml"))
	#print(parser.read())
	#parser.skip_section()
	pass # Replace with function body.


func _on_Boton_pressed():
	#print(OS.execute("C:\\ProgramData\\Anaconda3\\python.exe",args, true))
	write_file("miejemplo.txt","A.mp3")
	print(OS.execute("feature_ext.exe",args, true))
	pass
	
static func write_file(file_name, string):
	var file = File.new()
	file.open(file_name, File.WRITE)
	file.store_string(string)
	file.close()

static func read_file(file_name):
	var file = File.new()
	if !file.file_exists(file_name):
		return

	file.open(file_name, File.READ)

	var array = []
	while(!file.eof_reached()):
		var line = file.get_line()
		array.push_back(line)

	file.close()
	return array
