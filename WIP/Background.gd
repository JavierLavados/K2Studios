extends Node2D

onready var layer1 = $Layer1
onready var layer2 = [$Layer2a, $Layer2b]
onready var layer3 = [$Layer3a, $Layer3b]
onready var layer4 = [$Layer4a, $Layer4b]
onready var layers = layer2 + layer3 + layer4

var view_w = 1024

var counter = 0

func _ready():
	var t = "res://Sprites/Backgrounds/BgW" + str(Globals.current_world) + ".png"
	layer1.texture = load(t)

func _process(delta):
	var mov = delta*8
	for l in layer2:
		l.position.x += mov
	for l in layer3:
		l.position.x += mov*2
	for l in layer4:
		l.position.x += mov*4
	for l in layers:
		if l.position.x >= view_w:
			l.position.x = -view_w
