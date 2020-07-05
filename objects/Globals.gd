extends Node

var score = 0
var high_score = 0
var life_total = 3
var lifes = 0

func _ready():
	var save_data = File.new()
	save_data.open("user://save_data.save", File.READ)
	high_score = int(save_data.get_as_text())
	save_data.close()
