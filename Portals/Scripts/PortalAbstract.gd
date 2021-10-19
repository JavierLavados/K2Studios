extends Area2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var inside = false
var player_check = false
var player
var current

func get_player(id):
	var id_list = get_parent().ids
	if id in id_list:
		player = get_parent().players[id_list.find(id)]
	else:
		player = null
	player_check = true
	
func portal(id, key1, key2):
	
	if not player_check:
		get_player(id)
	
	animationPlayer.play("Move")
	
	if player:

		current = get_parent().current
		
		if current == id:
			if (Input.is_action_just_pressed(key1) or Input.is_action_just_pressed(key2)):
				if !player.exit:
					if inside:
						player.exit = true
						get_parent().ready += 1
				else:
					player.exit = false
					get_parent().ready -= 1
