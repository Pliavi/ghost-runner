extends HBoxContainer

var life_state_textures = {
	"empty": preload("res://sprites/HUD/Life/life_empty.png"),
	"filled": preload("res://sprites/HUD/Life/life_filled.png")
}

func _ready():
	for _i in range(Globals.life_total):
		Globals.lifes += 1
		add_life_slot()

func add_life_slot():
	var life = create_life()
	self.add_child(life)
	self.move_child(life, 0)
	
func create_life():
	var new_life = TextureRect.new()
	new_life.texture = self.life_state_textures.filled
	
	return new_life
	
func _on_hurt():
	Globals.lifes -= 1
	var life:TextureRect = self.get_child(Globals.lifes)
	life.texture = self.life_state_textures.empty
	
	if Globals.lifes == 0:
		self.get_tree().reload_current_scene()

func _on_dead():
	Globals.lifes = 0
	self.get_tree().reload_current_scene()
