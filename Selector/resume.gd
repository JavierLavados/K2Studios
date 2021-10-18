extends TextureButton





func _on_Resume_pressed():
	var new_paused_state = not get_tree().paused
	get_tree().paused = new_paused_state
	visible = new_paused_state
