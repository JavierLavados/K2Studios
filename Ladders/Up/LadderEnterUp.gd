extends Node2D

onready var sprite = $Sprite

var id = 0
var player_name = "PlayerUp"

func _ready():
	sprite.frame =  (8*(Globals.current_world-1)) + (id*2+1)

func _on_Ladder_body_entered(body):
	if body.name == player_name:
		body.on_ladder += 1
		body.detector_pos = [global_position,-1,true]

func _on_Ladder_body_exited(body):
	if body.name == player_name:
		body.on_ladder -= 1
		body.detector_pos = null

func _on_AreaZ_body_entered(body):
	if body.is_in_group("Players") and body.name != player_name:
		body.sprite.z_index -= 3

func _on_AreaZ_body_exited(body):
	if body.is_in_group("Players") and body.name != player_name:
		body.sprite.z_index += 3
