extends Control

var animation_finished = false

func _ready():
	$hi_score_label.text = "HiScore:%05d" % Globals.high_score
	$animation_player.play("Starting")

func _input(event):
	if event is InputEventScreenTouch:
		start_game()

	if event is InputEventKey and event.is_pressed() and !event.is_echo():
		if self.animation_finished:
			start_game()
		else:
			var full_time = $animation_player.current_animation_length
			$animation_player.seek(full_time)
			self.animation_finished = true

func start_game():
	var root = get_node("/root")

	var main_stage_resource = load("res://stages/Main.tscn")
	var main_stage = main_stage_resource.instance()
	root.add_child(main_stage)
	
	self.get_tree().current_scene = main_stage
	
	root.remove_child(self)
	self.call_deferred("free")

func _on_animation_player_animation_finished(_anim_name):
	self.animation_finished = true
