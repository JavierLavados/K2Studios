extends KinematicBody2D

const gravity = 25
const NORMAL = Vector2(-1,0)
const MAX_SPEED = 96

onready var sprite = $Sprite
onready var ray = $RayCast2D
onready var coll = $CollisionShape2D

var on_left = false
var on_right = false
var motion = Vector2(0,0)
var target_pos = 0
var id = 3
var counter = 0
var can_switch = true

var pusher

func _ready():
	sprite.frame = (4*(Globals.current_world-1)) + id

func _process(delta):
	if counter > 0:
		set_physics_process(false)
	else:
		set_physics_process(true)

func _physics_process(delta):

	if motion.dot(NORMAL) > -300:
		motion += -gravity * NORMAL

	if on_left and Input.get_action_strength("up") == 1 and ray.is_colliding():
		target_pos = 1
	if on_right and Input.get_action_strength("down") == 1 and ray.is_colliding():
		target_pos = -1
		
	if pusher:
		if (on_left and Input.get_action_strength("up") == 1) or (on_right and Input.get_action_strength("down") == 1):
			pusher.pushing = true
		else:
			pusher.pushing = false
		
	var prev_switch = can_switch
	
	if target_pos != 0:
		can_switch = false
		motion.y = -target_pos * 48
		coll.shape.extents.x = 15
		coll.position.x = 1
	else:
		motion.y = 0
		coll.shape.extents.x = 16
		coll.position.x = 0
		if !ray.is_colliding():
			can_switch = false
			coll.shape.extents.y = 14
		else:
			can_switch = true
			coll.shape.extents.y = 16
		position.y = int(position.y)
			
	if prev_switch != can_switch:
		if can_switch:
			get_parent().switch_restriction -= 1
		else:
			get_parent().switch_restriction += 1
		
	move_and_slide(motion)
	
	if int(position.y)%32 == 16:
		target_pos = 0

func _on_AreaLeft_body_entered(body):
	if body.name == "PlayerLeft":
		pusher = body
		on_left = true

func _on_AreaLeft_body_exited(body):
	if body.name == "PlayerLeft":
		on_left = false

func _on_AreaRight_body_entered(body):
	if body.name == "PlayerLeft":
		pusher = body
		on_right = true

func _on_AreaRight_body_exited(body):
	if body.name == "PlayerLeft":
		on_right = false

func _on_AreaDown_body_entered(body):
	if body.is_in_group("PlayerLeft"):
		body.move_and_slide(motion)

func _on_AreaAll_body_entered(body):
	if body.is_in_group("Players") and body.name != "PlayerLeft":
		counter += 1

func _on_AreaAll_body_exited(body):
	if body.is_in_group("Players") and body.name != "PlayerLeft":
		counter -= 1
