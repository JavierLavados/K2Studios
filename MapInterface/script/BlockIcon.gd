extends Node2D

export var required = 1
export var world = 1
export var id = 1

onready var sprite = $Sprite
onready var bubble = $Sprite2
onready var dec = $Sprite2/Decena
onready var uni = $Sprite2/Unidad
onready var animationPlayer = $AnimationPlayer

var accum = 0
var cleared = false
var deleted = false

var texture = "res://Sprites/StopBlocks/StopBlockW"

func _ready():
	var t = texture + str(world) + ".png"
	sprite.texture = load(t)
	
	var decena = required/10
	var unidad = required%10
	if decena == 0:
		dec.visible = false
		uni.frame = unidad
		uni.position.x = 0
	else:
		dec.frame = decena
		uni.frame = unidad
		if decena == 1:
			uni.position.x -= 2
		if unidad == 1:
			dec.position.x += 2
		
	if  Globals.block_status[id-1]:
		visible=false
		
	if required <= Globals.current_points:
		animationPlayer.play("Glowing")
		cleared = true
	else:
		animationPlayer.play("Idle")
	
	if cleared:
		bubble.visible = false

func _process(delta):	
	accum += delta
	bubble.position.y = -64 + sin(5*accum)

func _on_Area2D_body_entered(body):
	if !cleared:
		body.get_parent().go_back = true

func _on_BigArea_body_entered(body):
	if cleared and not deleted:
		animationPlayer.play("Vanish")
		deleted = true
		Globals.block_status[id-1]=true
