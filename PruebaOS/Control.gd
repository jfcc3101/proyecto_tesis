extends Control

#var parser = XMLParser.new()
#var cancion = Array()
# Called when the node enters the scene tree for the first time.
var args = ["python feature_ext.py"]
func _ready():
	
	#print(parser.open("res://saves/actual.xml"))
	#print(parser.read())
	#parser.skip_section()
	pass # Replace with function body.


func _on_Boton_pressed():
	print(OS.execute("cmd.exe",args, true))
	pass
