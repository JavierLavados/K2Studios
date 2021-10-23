extends Sprite


func _ready():
	get_parent().get_node("Tutorial1").visible = true
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_parent().get_node("Tutorial1").visible = false
		get_tree().paused = false



