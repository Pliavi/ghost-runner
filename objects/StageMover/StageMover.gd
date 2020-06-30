extends Node2D

export var stage_speed = 80
var last_platform:Node2D
onready var platforms := [
	preload("res://tilesets/Grass/Platform01.tscn"),
	preload("res://tilesets/Grass/Platform02.tscn"),
	preload("res://tilesets/Grass/Platform03.tscn")
]
onready var character_position = self.get_parent().get_node("Character").global_position

func _ready():
	randomize()
	self.add_platform()

func add_platform():
	var random_number = randi() % 5 
	var fall_space = 16 if random_number == 2 else 0
	
	var new_vertical_height = 0
	if random_number == 2:
		new_vertical_height = -1
	if random_number == 3:
		new_vertical_height = 1
	
	var random_platform = randi() % len(platforms)
	var new_platform = platforms[random_platform].instance()
	self.add_child(new_platform)
	
	if last_platform:
		var last_platform_position = last_platform.get_node("end_position").global_position
		var horizontal_pos = last_platform_position.x + fall_space 
		var vertical_pos = last_platform_position.y + new_vertical_height * 16
		
		new_platform.global_position = Vector2(horizontal_pos, vertical_pos)
	else:
		var screen_height = get_viewport_rect().size.y

		new_platform.global_position = Vector2(0, screen_height)
		
	last_platform = new_platform

func _physics_process(delta):
	self.global_position.x -= stage_speed * delta
	
	var last_platform_position = last_platform.get_node("end_position").global_position
	
	if (last_platform_position.x - character_position.x) < 200:
		self.add_platform()
	
