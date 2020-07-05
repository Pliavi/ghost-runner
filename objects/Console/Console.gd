extends TextureRect

func _ready():
	$buttons/music_toggle/music_toggle.visible = !Globals.is_music_on
	$buttons/fx_toggle/fx_toggle.visible = !Globals.is_fx_on
	self.toggle_music_to(Globals.is_music_on)
	self.toggle_fx_to(Globals.is_fx_on)
	center_game_screen()

func toggle_music_to(on):
	Globals.is_music_on = on
	self.owner.get_node("music").playing = on

func toggle_fx_to(on):
	Globals.is_fx_on = on

func _on_music_toggle_pressed():
	toggle_music_to(!Globals.is_music_on)
	$buttons/music_toggle/music_toggle.visible = !Globals.is_music_on

func _on_fx_toggle_pressed():
	toggle_fx_to(!Globals.is_fx_on)
	$buttons/fx_toggle/fx_toggle.visible = !Globals.is_fx_on

func _on_fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	if OS.window_fullscreen == false:
		OS.window_size = get_viewport_rect().size * 3
		center_game_screen()

func center_game_screen():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)

func _on_close_pressed():
	get_tree().quit()

func _on_goto_home_released():
	get_tree().change_scene("res://stages/Start.tscn")
	Globals.lifes = 0
