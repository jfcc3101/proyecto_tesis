extends Control

#var parser = XMLParser.new()
#var cancion = Array()
# Called when the node enters the scene tree for the first time.
#var args = ["feature_ext.py"]
var args = ["runfile('D:/Documentos/GitHub/proyecto_tesis/PruebaOS/feature_ext.py'), wdir='D:/Documentos/GitHub/proyecto_tesis/PruebaOS')"]
func _ready():
	
	#print(parser.open("res://saves/actual.xml"))
	#print(parser.read())
	#parser.skip_section()
	pass # Replace with function body.


func _on_Boton_pressed():
	#print(OS.execute("C:\\ProgramData\\Anaconda3\\python.exe",args, true))
	print(OS.execute("C:\\ProgramData\\Anaconda3\\Scripts\\spyder.exe",args, true))
	pass
