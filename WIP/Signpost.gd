extends Area2D

onready var sprite = $Sprite
onready var coll = $CollisionShape2D
onready var pos = $Position2D
onready var arrow = $Position2D/ArrowKey
onready var tutorial = $Tutorial
export var id = 0
export var message = "res://Sprites/Backgrounds/BgW6.png"

var inside = null

func _ready():
	$Tutorial.texture=load(message)
	$Tutorial.position = Vector2(512-position.x,320-position.y)
	$Marco.position = Vector2(512-position.x,320-position.y)
	
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
			match id:
				0:
					if Input.is_action_just_pressed("up"):
						get_parent().freeze_players=(get_parent().freeze_players+1)%2
						get_parent().switch_restriction=(get_parent().switch_restriction+1)%2
						$Tutorial.visible=!$Tutorial.visible
						$Marco.visible=!$Marco.visible
				1:
					if Input.is_action_just_pressed("right"):
						get_parent().freeze_players=(get_parent().freeze_players+1)%2
						get_parent().switch_restriction=(get_parent().switch_restriction+1)%2
						$Tutorial.visible=!$Tutorial.visible
						$Marco.visible=!$Marco.visible
				2:
					if Input.is_action_just_pressed("down"):
						get_parent().freeze_players=(get_parent().freeze_players+1)%2
						get_parent().switch_restriction=(get_parent().switch_restriction+1)%2
						$Tutorial.visible=!$Tutorial.visible
						$Marco.visible=!$Marco.visible
				3:
					if Input.is_action_just_pressed("left"):
						get_parent().freeze_players=(get_parent().freeze_players+1)%2
						get_parent().switch_restriction=(get_parent().switch_restriction+1)%2
						$Tutorial.visible=!$Tutorial.visible
						$Marco.visible=!$Marco.visible
				
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
