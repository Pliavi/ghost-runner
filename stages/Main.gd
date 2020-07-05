extends Node2D

func _ready():
	self.get_tree().current_scene = self

func _on_dead():
	Globals.lifes = 0
	if Globals.high_score < Globals.score:
		Globals.high_score = Globals.score 
	Globals.score = 0
	save_high_score()
	self.get_tree().reload_current_scene()

func save_high_score():
	var save_data = File.new()
	save_data.open("user://save_data.save", File.WRITE)
	save_data.store_line(str(Globals.high_score))
	save_data.close()
	
