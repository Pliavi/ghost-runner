extends TextureRect

var following = false
var dragging_start_position = Vector2()

func _on_Console_gui_input(event):
	if not OS.window_fullscreen:
		if event is InputEventMouseButton:
			if event.button_index == 1:
				following = not following
				dragging_start_position = get_local_mouse_position()

func _process(_delta):
	if following:
		OS.window_position = \
			OS.window_position + \
			get_global_mouse_position() - dragging_start_position

func _on_music_toggle_pressed():
	Globals.is_music_on = !Globals.is_music_on
	$buttons/music_toggle/music_toggle.visible = !Globals.is_music_on

func _on_fx_toggle_pressed():
	Globals.is_fx_on = !Globals.is_fx_on
	$buttons/fx_toggle/fx_toggle.visible = !Globals.is_fx_on
