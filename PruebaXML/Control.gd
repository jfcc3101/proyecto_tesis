extends Control

var parser = XMLParser.new()
var cancion = Array()
# Called when the node enters the scene tree for the first time.
func _ready():
	print(parser.open("res://saves/actual.xml"))
	#print(parser.read())
	#parser.skip_section()
	pass # Replace with function body.


func _on_Boton_pressed():
	for j in range(1,16):
		var path = ""
		while (path == ""):
			parser.read()
			path = parser.get_node_data()
		cancion.append(path)
	#print(path)
	
	print(len(cancion))
	#print(cancion[2])
	cancion[2][0] = ""
	#cancion[2].erase(0, '[')
	var tempo = cancion[2].split(" ")
	
	print(tempo[200])
	#for i in range(0,len(cancion)):
	#	print(cancion[i])
	pass