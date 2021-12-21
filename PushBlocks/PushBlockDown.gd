extends KinematicBody2D

const gravity = 25
const NORMAL = Vector2(0,1)
const MAX_SPEED = 96

onready var sprite = $Sprite
onready var ray = $RayCast2D
onready var left = $RayLeft
onready var right = $RayRight
onready var ray_up = $RayUp
onready var coll = $CollisionShape2D

var on_left = false
var on_right = false
var motion = Vector2(0,0)
var target_pos = 0
var id = 2
var counter = 0
var can_switch = true
var freeze = false

var added = false
var subst = false

var midpoint = false
var in_midpoint = false
var pusher

func _ready():
	sprite.frame = (4*(Globals.current_world-1)) + id

func _process(delta):
	
	var block_on_top = false
	var coll = ray_up.get_collider()
	if coll:
		if coll.is_in_group("Blocks"):
			block_on_top = true
			
	if counter > 0 or block_on_top:
		set_physics_process(false)
	else:
		set_physics_process(true)

func _physics_process(delta):

	if motion.dot(NORMAL) > -300:
		motion += -gravity * NORMAL

	if on_left and Input.get_action_strength("left") == 1 and ray.is_colliding() and !right.is_colliding() and pusher.floored:
		target_pos = 1
	if on_right and Input.get_action_strength("right") == 1 and ray.is_colliding() and !left.is_colliding() and pusher.floored:
		target_pos = -1
		
	if pusher:
		if (on_left and Input.get_action_strength("left") == 1) or (on_right and Input.get_action_strength("right") == 1):
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
	var prev_freeze = freeze
	
	# Si la caja se esta moviendo, disminuir el hitbox
	if target_pos != 0:
		can_switch = false
		motion.x = -target_pos * 48
		coll.shape.extents.y = 15
		coll.position.y = -1
	else:
		motion.x = 0
		coll.shape.extents.y = 16
		coll.position.y = 0
		
	# Si la caja esta flotando, disminuir el hitbox
	if !ray.is_colliding():
		can_switch = false
		coll.shape.extents.x = 14
		if midpoint:
			freeze = true
	else:
		coll.shape.extents.x = 16

	# Si la caja esta en el suelo y sin moverse, resetear variables
	if ray.is_colliding() and target_pos == 0:
		can_switch = true
		freeze = false
	
	# Chequeo punto medio
	if target_pos != 0 and not midpoint:
		if int(position.x)%32 >= 30 or int(position.x)%32 <= 2:
			midpoint = true
			
	if int(position.x)%32 >= 31 or int(position.x)%32 <= 1:
		in_midpoint = true
	else:
		in_midpoint = false
		
	# Restricciones de cambio de personaje y de movimiento
	if prev_switch != can_switch:
		if can_switch:
			get_parent().switch_restriction -= 1
		else:
			get_parent().switch_restriction += 1
	
	if prev_freeze != freeze:
		if freeze:
			get_parent().freeze_players += 1
		else:
			get_parent().freeze_players -= 1
		
	# Movimiento final
	move_and_slide(motion)

	# Calculo de fin de movimiento
	if target_pos != 0 and midpoint:
		if int(round(position.x))%32 == 16:  
			target_pos = 0
			position.x = int(round(position.x))
	
	if in_midpoint:
		if (left.is_colliding() and target_pos == -1) or (right.is_colliding() and target_pos == 1):
			target_pos = 0
			position.x = int(round(position.x))
	
	if ray.is_colliding() and target_pos == 0:
		midpoint = false

func _on_AreaLeft_body_entered(body):
	if body.name == "PlayerDown":
		pusher = body
		on_left = true

func _on_AreaLeft_body_exited(body):
	if body.name == "PlayerDown":
		on_left = false

func _on_AreaRight_body_entered(body):
	if body.name == "PlayerDown":
		pusher = body
		on_right = true
		
func _on_AreaRight_body_exited(body):
	if body.name == "PlayerDown":
		on_right = false

func _on_AreaDown_body_entered(body):
	if body.is_in_group("Players"):
		get_parent().gameOver()

func _on_AreaAll_body_entered(body):
	if body.is_in_group("Players") and body.name != "PlayerDown":
		counter += 1

func _on_AreaAll_body_exited(body):
	if body.is_in_group("Players") and body.name != "PlayerDown":
		counter -= 1
