extends RigidBody2D

onready var coll = $CollisionShape2D
onready var sprite = $Sprite
"""
func _on_Area2D_body_entered(body):
	if body.is_in_group("Players") and body.name != "PlayerUp":
		coll.set_deferred("disabled",true)
		sprite.visible = false

func _on_Area2D_body_exited(body):
	pass # Replace with function body.
"""
