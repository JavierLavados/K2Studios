extends KinematicBody2D

const gravity = 25
const NORMAL = Vector2(-1,0)
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
var id = 3
var counter = 0
var can_switch = true
var freeze = false

var added = false
var subst = false

var midpoint = false
var in_midpoint = false
var pusher
var coll_left = 0
var coll_right = 0

func _ready():
	sprite.frame = (4*(Globals.current_world-1)) + id

func _process(delta):
	
	var block_on_top = false
	var on_top = ray_up.get_collider()
	if on_top:
		if on_top.is_in_group("Blocks") and on_top.id == id:
			block_on_top = true
			
	if counter > 0 or block_on_top:
		coll.shape.extents.y = 16
		set_physics_process(false)
	else:
		set_physics_process(true)

func _physics_process(delta):

	if motion.dot(NORMAL) > -300:
		motion += -gravity * NORMAL

	if on_left and Input.get_action_strength("up") == 1 and ray.is_colliding() and !right.is_colliding():
		if pusher.floored and coll_right == 0:
			target_pos = 1
	if on_right and Input.get_action_strength("down") == 1 and ray.is_colliding() and !left.is_colliding():
		if pusher.floored and coll_left == 0:
			target_pos = -1
		
	if pusher:
		if (on_left and Input.get_action_strength("up") == 1) or (on_right and Input.get_action_strength("down") == 1):
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
		motion.y = -target_pos * 48
		coll.shape.extents.x = 15
		coll.position.x = 1
	else:
		motion.y = 0
		coll.shape.extents.x = 16
		coll.position.x = 0
	
	# Si la caja esta flotando, disminuir el hitbox
	if !ray.is_colliding():
		can_switch = false
		coll.shape.extents.y = 14
		if midpoint:
			freeze = true
	else:
		coll.shape.extents.y = 15.8
		
	# Si la caja esta en el suelo y sin moverse, resetear variables
	if ray.is_colliding() and target_pos == 0:
		can_switch = true
		freeze = false
		
	# Chequeo punto medio
	if target_pos != 0 and not midpoint:
		if int(position.y)%32 >= 30 or int(position.y)%32 <= 2:
			midpoint = true
			
	if int(position.y)%32 >= 31 or int(position.y)%32 <= 1:
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
		if int(round(position.y))%32 == 16:  
			target_pos = 0
			position.y = int(round(position.y))
	
	if in_midpoint:
		if (left.is_colliding() and target_pos == -1) or (right.is_colliding() and target_pos == 1):
			target_pos = 0
			position.y = int(round(position.y))
	
	if ray.is_colliding() and target_pos == 0:
		midpoint = false

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
	if body.is_in_group("Players"):
		get_parent().gameOver()

func _on_AreaAll_body_entered(body):
	if body.is_in_group("Players") and body.name != "PlayerLeft":
		counter += 1

func _on_AreaAll_body_exited(body):
	if body.is_in_group("Players") and body.name != "PlayerLeft":
		counter -= 1

func _on_CollisionLeft_body_entered(body):
	if body.is_in_group("Players") and body.name != "PlayerLeft":
		coll_left += 1

func _on_CollisionLeft_body_exited(body):
	if body.is_in_group("Players") and body.name != "PlayerLeft":
		coll_left -= 1

func _on_CollisionRight_body_entered(body):
	if body.is_in_group("Players") and body.name != "PlayerLeft":
		coll_right += 1

func _on_CollisionRight_body_exited(body):
	if body.is_in_group("Players") and body.name != "PlayerLeft":
		coll_right -= 1
