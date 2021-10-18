extends TextureButton

export var level_int = 1
export var level_proyect_dir = ''

func _ready():
	if level_int<= Globals.current_level:
		disabled = false
	else:
		disabled = true

func _on_btn_pressed():
	if level_proyect_dir != '':
		get_tree().change_scene(level_proyect_dir)
		
