extends ParallaxBackground

onready var layer1 = $ParallaxLayer
onready var layer2 = $ParallaxLayer2

func _process(delta):
	scroll_offset.y = 500 * delta
