extends KinematicBody2D

const gravity = 25
const NORMAL = Vector2(0, -1)
const MAX_SPEED = 96

onready var ray = $RayCast2D
onready var coll = $CollisionShape2D

var on_left = false
var on_right = false
var motion = Vector2(0,0)
var target_pos = 0
var id = 0

func _physics_process(delta):

	if motion.dot(NORMAL) > -300:
		motion += -gravity * NORMAL

	if on_left and Input.get_action_strength("right") == 1 and ray.is_colliding():
		target_pos = 1
	if on_right and Input.get_action_strength("left") == 1 and ray.is_colliding():
		target_pos = -1
	
	if target_pos != 0:
		motion.x = target_pos * 48
		coll.shape.extents.y = 15
		coll.position.y = 1
	else:
		motion.x = 0
		coll.shape.extents.y = 16
		coll.position.y = 0
	
	if !ray.is_colliding() and target_pos == 0:
		coll.shape.extents.x = 14
	else:
		coll.shape.extents.x = 16

	move_and_slide(motion)
	
	if int(position.x)%32 == 16:
		target_pos = 0

func _on_AreaLeft_body_entered(body):
	if body.name == "PlayerUp":
		on_left = true

func _on_AreaLeft_body_exited(body):
	if body.name == "PlayerUp":
		on_left = false

func _on_AreaRight_body_entered(body):
	if body.name == "PlayerUp":
		on_right = true

func _on_AreaRight_body_exited(body):
	if body.name == "PlayerUp":
		on_right = false


func _on_AreaDown_body_entered(body):
	if body.is_in_group("Players"):
		get_parent().gameOver()
