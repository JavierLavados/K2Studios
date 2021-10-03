extends Node2D

onready var layer2 = [$Layer2a, $Layer2b]
onready var layer3 = [$Layer3a, $Layer3b]
onready var layer4 = [$Layer4a, $Layer4b]
onready var layers = layer2 + layer3 + layer4

var view_w = 1024

var counter = 0

func _process(delta):
	if counter%8 == 0:
		for l in layer2:
			l.position.x += 1
	if counter%4 == 0:
		for l in layer3:
			l.position.x += 1
	if counter % 2 == 0:
		for l in layer4:
			l.position.x += 1
			print(l.position.x)
	counter = (counter+1)%8
	for l in layers:
		if l.position.x >= view_w:
			l.position.x = -view_w
