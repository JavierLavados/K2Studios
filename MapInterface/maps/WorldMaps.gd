extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.set_position(Vector2(512+1024*(Globals.current_world-1),320))

func _on_Transition12_body_entered(body):
	
	var pos = $MapPointer.get_position()
	#print(pos)
	if pos.x<1024:
		Globals.current_world=Globals.current_world+1
		#print($Camera2D.get_position())
		$Camera2D.set_position(Vector2(512+1024,320))
	else:
		Globals.current_world=Globals.current_world-1
		#print($Camera2D.get_position())
		$Camera2D.set_position(Vector2(512,320))


func _on_Transition23_body_entered(body):
	var pos = $MapPointer.get_position()
	#print(pos)
	if pos.x<2048:
		Globals.current_world=Globals.current_world+1
		#print($Camera2D.get_position())
		$Camera2D.set_position(Vector2(512+2048,320))
	else:
		Globals.current_world=Globals.current_world-1
		#print($Camera2D.get_position())
		$Camera2D.set_position(Vector2(512+1024,320))
