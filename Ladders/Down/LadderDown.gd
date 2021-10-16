extends Node2D

onready var sprite = $Sprite

var id = 2
var player_name = "PlayerDown"

func _on_Ladder_body_entered(body):
	if body.name == player_name:
		body.on_ladder += 1

func _on_Ladder_body_exited(body):
	if body.name == player_name:
		body.on_ladder -= 1

func _on_AreaZ_body_entered(body):
	if body.is_in_group("Players") and body.name != player_name:
		body.sprite.z_index -= 3

func _on_AreaZ_body_exited(body):
	if body.is_in_group("Players") and body.name != player_name:
		body.sprite.z_index += 3
