extends Node2D

export var stage_speed = 80
var last_platform:Node2D
onready var platforms := [
	preload("res://tilesets/Grass/Platform00.tscn"),
	preload("res://tilesets/Grass/Platform01.tscn"),
	preload("res://tilesets/Grass/Platform02.tscn"),
	preload("res://tilesets/Grass/Platform03.tscn"),
	preload("res://tilesets/Grass/Platform04.tscn"),
]
onready var character_position = self.get_node("/root/Stage").get_node("Character").global_position
	
var platform_height = 0
var is_moving = true

func _ready():
	randomize()
	self.add_platform()

func add_platform():
	var random_number = randi() % 5 
	var fall_space = 16
	
	var is_platform_go_up = random_number == 2 and platform_height < 3
	var is_platform_go_down = random_number == 3 and platform_height > 0
	if is_platform_go_up:
		platform_height += 1
	if is_platform_go_down:
		platform_height -= 1
	
	var random_platform = \
		randi() % len(platforms) if last_platform \
		else 0
	
	var new_platform = platforms[random_platform].instance()
	self.add_child(new_platform)
	
	if last_platform:
		var last_platform_position = last_platform.get_node("end_position").global_position
		var vertical_pos = get_viewport_rect().size.y + (-platform_height * 16) - 16
		var horizontal_pos = last_platform_position.x + fall_space 
		
		new_platform.global_position = Vector2(horizontal_pos, vertical_pos)
	else:
		var screen_height = get_viewport_rect().size.y - 16

		new_platform.global_position = Vector2(0, screen_height)
	last_platform = new_platform

func _process(delta):
	var last_platform_position = last_platform.get_node("end_position").global_position
	if (last_platform_position.x - character_position.x) < 200:
		self.add_platform()

	if is_moving:
		self.position.x -= stage_speed * delta
		self.stage_speed += stage_speed * delta / 96
		Globals.score += (stage_speed * delta) / 16

func _on_Character_pre_dead():
	is_moving = false
