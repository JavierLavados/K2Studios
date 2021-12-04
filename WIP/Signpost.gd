extends Area2D

onready var sprite = $Sprite
onready var coll = $CollisionShape2D
onready var pos = $Position2D
onready var arrow = $Position2D/ArrowKey

export var id = 0

var inside = null

func _ready():
	
	sprite.frame = (4*(Globals.current_world-1)) + id
	
	if id%2 != 0:
		coll.shape.extents.x = 8
		coll.shape.extents.y = 4
	
	match id:
		0:
			pos.position.y = -32
		1:
			pos.position.x = 32
		2:
			pos.position.y = 32
		3:
			pos.position.x = -32
	
	arrow.id = id

		
func _process(delta):
	if inside:
		if inside.awake:
			arrow.visible = true
	else:
		arrow.visible = false
		

func _on_Signpost_body_entered(body):
	if body.is_in_group("Players"):
		if body.id == id:
			inside = body
			

func _on_Signpost_body_exited(body):
	if body.is_in_group("Players"):
		if body.id == id:
			inside = null
