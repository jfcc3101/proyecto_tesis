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
	print("Cancion: " + cancion[0])
	print("Tempo Medio: " + cancion[1])
	#cancion[5] = cancion[5].replace("[","")
	#cancion[5] = cancion[5].rsplit(" ")
	cancion[1] = float(cancion[1])
	for i in range(2,len(cancion)-1):
		cancion[i] = cancion[i].replace("[","")
		cancion[i] = cancion[i].rsplit(" ")
		print(cancion[i][0])
	for i in range(2,len(cancion)-1):
		cancion[i] = Array(cancion[i])
		for k in range(0,len(cancion[i])-1):
			#cancion[i][k] = str(cancion[i][k])
			cancion[i][k] = cancion[i][k].to_float()
		
	print("suma" + str(cancion[3][0] + cancion[4][0]))
	#cancion[2][0] = ""
	#cancion[2].erase(0, '[')
	"""var tempo = Array(cancion[2])
	for l in range(1,len(tempo)-1):
		tempo[l] = float(tempo[l])"""
	
	#print(tempo[200])
	#for i in range(0,len(cancion)):
	#	print(cancion[i])
	pass
