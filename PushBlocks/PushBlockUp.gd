extends KinematicBody2D

const gravity = 25
const NORMAL = Vector2(0, -1)
const MAX_SPEED = 96

onready var sprite = $Sprite
onready var ray = $RayCast2D
onready var coll = $CollisionShape2D

var on_left = false
var on_right = false
var motion = Vector2(0,0)
var target_pos = 0
var id = 0
var counter = 0
var can_switch = true

var added = false
var subst = false

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

	if on_left and Input.get_action_strength("right") == 1 and ray.is_colliding():
		target_pos = 1
	if on_right and Input.get_action_strength("left") == 1 and ray.is_colliding():
		target_pos = -1
		
	if pusher:
		if (on_left and Input.get_action_strength("right") == 1) or (on_right and Input.get_action_strength("left") == 1):
			if not added:
				pusher.pushing = true
				added = true
				subst = false
		else:
			if not subst:
				pusher.pushing = false
				subst = true
				added = false
		
	var prev_switch = can_switch
	
	if target_pos != 0:
		can_switch = false
		motion.x = target_pos * 48
		coll.shape.extents.y = 15
		coll.position.y = 1
	else:
		motion.x = 0
		coll.shape.extents.y = 16
		coll.position.y = 0
		if !ray.is_colliding():
			can_switch = false
			coll.shape.extents.x = 14
		else:
			can_switch = true
			coll.shape.extents.x = 16
		position.x = int(position.x)
			
	if prev_switch != can_switch:
		if can_switch:
			get_parent().switch_restriction -= 1
		else:
			get_parent().switch_restriction += 1
		
	move_and_slide(motion)
	
	if int(position.x)%32 == 16:
		target_pos = 0

func _on_AreaLeft_body_entered(body):
	if body.name == "PlayerUp":
		pusher = body
		on_left = true

func _on_AreaLeft_body_exited(body):
	if body.name == "PlayerUp":
		on_left = false

func _on_AreaRight_body_entered(body):
	if body.name == "PlayerUp":
		pusher = body
		on_right = true

func _on_AreaRight_body_exited(body):
	if body.name == "PlayerUp":
		on_right = false

func _on_AreaDown_body_entered(body):
	if body.is_in_group("Players"):
		body.move_and_slide(motion)

func _on_AreaAll_body_entered(body):
	if body.is_in_group("Players") and body.name != "PlayerUp":
		counter += 1

func _on_AreaAll_body_exited(body):
	if body.is_in_group("Players") and body.name != "PlayerUp":
		counter -= 1
