extends StaticBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite
var id = 0

var on_top = null
var inside = false

func _ready():
	sprite.frame = 4 * (Globals.current_world-1) + id
	
func _physics_process(delta):
	if on_top:
		if Input.is_action_just_pressed("down"):
			if not inside:
				inside = true
				on_top.trampoline = true
		if Input.is_action_just_pressed("up"):
			if inside:
				inside = false
				on_top.trampoline = false

	if inside:
		coll.shape.extents.y = 8
		coll.position.y = 8
		sprite.frame = 8 * (Globals.current_world-1) + (2*id) + 1
	else:
		coll.shape.extents.y = 15
		coll.position.y = 1
		sprite.frame = 8 * (Globals.current_world-1) + (2*id)

func _on_Area2D_body_entered(body):
	if body.name == "PlayerUp":
		on_top = body

func _on_Area2D_body_exited(body):
	if body.name == "PlayerUp":
		on_top = null
		inside = false
		body.trampoline = false
