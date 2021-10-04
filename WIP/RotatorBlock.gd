extends RigidBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite

func _physics_process(delta):
	if get_parent().moving == true:
		coll.disabled = true
		sprite.frame = 32
	else:
		coll.disabled = false
		sprite.frame = 24

func _on_Area2D_body_entered(body):
	if body.is_in_group("Players"):
		get_parent().collisions += 1

func _on_Area2D_body_exited(body):
	if body.is_in_group("Players"):
		get_parent().collisions -= 1
