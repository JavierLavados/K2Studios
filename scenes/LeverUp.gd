extends Area2D

onready var sprite = $Sprite

var dentro = false
var on = false

var current

func _physics_process(delta):
	current = get_parent().current

	if current == 0:
		if (Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down")) and dentro:
			if on:
				on = false
				get_parent().lever = 4
			else:
				on = true
				get_parent().lever = current
		
	if get_parent().lever != 0:
		on = false
		
	if on:
		sprite.frame = 41
	else:
		sprite.frame = 40

func _on_LeverUp_body_entered(body):
	if body.name == "PlayerUp":
			dentro = true
			
func _on_LeverUp_body_exited(body):
	dentro = false
