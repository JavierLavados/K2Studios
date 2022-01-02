extends KinematicBody2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var pointer
var leave = 0
var motion = Vector2(0,0)

func setUp(texture):
	var t = texture + str(Globals.current_world) + ".png"
	sprite.texture = load(t)
	
	pointer = get_parent()
	
func playerMap(texture, id, target):
	var t = texture + str(Globals.current_world) + ".png"
	sprite.texture = load(t)
	
	# Parte 1: Movimiento en diagonal para salir del nivel
	if leave == 1:
		animationPlayer.play("Walking")
		var on_path = false
		if pointer.last_dir % 2 == 0:
			if global_position.x <= pointer.target_node.x+1 and global_position.x >= pointer.target_node.x-1:
				global_position.x = pointer.target_node.x
				on_path = true
			if id < 2:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
		else:
			if global_position.y <= pointer.target_node.y +1 and global_position.y >= pointer.target_node.y-1:
				global_position.y = pointer.target_node.y
				on_path = true
			if pointer.last_dir == 1:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
		if on_path:
			leave = 2
		else:
			match pointer.last_dir:
				0:
					motion = Vector2(0,-32) - target
				1:
					motion = Vector2(32,0) - target
				2:
					motion = Vector2(0,32) - target
				3:
					motion = Vector2(-32,0) - target
			motion = motion * 3
	
	# Parte 2: Desplazarse por la arista
	if leave == 2:
		match pointer.last_dir:
			0:
				motion = Vector2(0,-240)
				animationPlayer.play("SmallUp")
			1:
				motion = Vector2(240,0)
				sprite.flip_h = false
				animationPlayer.play("SmallSide")
			2:
				motion = Vector2(0,240)
				animationPlayer.play("SmallDown")
			3:
				motion = Vector2(-240,0)
				sprite.flip_h = true
				animationPlayer.play("SmallSide")
	
	if leave == 3:
		animationPlayer.play("Walking")
		if pointer.last_dir % 2 == 0:
			if id < 2:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
		else:
			if pointer.last_dir == 1:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
		match pointer.last_dir:
			0:
				motion = target - Vector2(0,32)
			1:
				motion = target - Vector2(-32,0)
			2:
				motion = target - Vector2(0,-32)
			3:
				motion = target - Vector2(32,0)
		motion = motion*3
				
		var target_x = target.x + pointer.target_node.x
		var target_y = target.y + pointer.target_node.y
		
		if pointer.last_dir % 2 == 0:
			if global_position.x <= target_x+1 and global_position.x >= target_x-1:
				leave = 0
		else:
			if global_position.y <= target_y+1 and global_position.y >= target_y-1:
				leave = 0

	# Restaurar valores
	if leave == 0:
		animationPlayer.play("Idle")
		motion = Vector2(0,0)
		global_position = target + pointer.target_node

	move_and_slide(motion)

