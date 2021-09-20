extends Block
class_name PushBlock

var motion = Vector2()

func push(hspd):
	move_and_slide(Vector2(hspd*0.9, 0), Vector2(0,-1))
	
func _physics_process(delta):
	motion += Vector2(0,60)
	if not is_on_floor():
		motion.x = 0
	motion = move_and_slide(motion, Vector2(0,-1))
