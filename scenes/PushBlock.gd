extends Block
class_name PushBlock

func push(hspd):
	move_and_slide(Vector2(hspd,0), Vector2(0,-1))
