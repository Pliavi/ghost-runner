extends Node2D

func _ready():
	var last_life = $container/life
	for _i in range(Globals.life_total - 1):
		var new_life = $container/life.duplicate()
		self.get_node("container").add_child(new_life)
		new_life.global_position = last_life.global_position
		new_life.global_position.x += 9
		last_life = new_life
	$closing.global_position.x = last_life.global_position.x + 9

func _on_hurt_box_body_entered(_body):
	if Globals.lifes > 1:
		Globals.lifes -= 1
		var hurt_life = self.get_node("container").get_children()[Globals.lifes]
		hurt_life.region_rect.position.x = 9
	else:
		Globals.lifes = 2
		self.get_tree().reload_current_scene()
	