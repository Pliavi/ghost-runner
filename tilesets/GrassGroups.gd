extends TileMap

var groups = [
	# initial_pos, final_pos   , group_width
	[Vector2(0,1), Vector2(2,2), 3],
	[Vector2(3,1), Vector2(5,2), 3],
	[Vector2(6,1), Vector2(8,3), 3],
]
const TILE_SIZE = 16
var rendered_groups = []
var x_position_to_put_next_tile = 0
var last_group_width = 1

func _ready():
	var group_width = 0
	for group in groups:
		var initial_pos = group[0]
		var final_pos = group[1]
		var current_group_width = group[2]
		
		var temp_group = []
		for x in range(initial_pos.x, final_pos.x + 1):
			for y in range(initial_pos.y, final_pos.y + 1):
				var cell_id = get_cell(x, -y)
				if cell_id != -1:
					var cell_metadata = [x - group_width, -y, cell_id]
					temp_group.push_front(cell_metadata)
					
		rendered_groups.push_front([temp_group, current_group_width])
		group_width += current_group_width 
	
	for cell in self.get_used_cells():
		self.set_cell(cell.x, cell.y, -1)
	add_tile()


func _process(delta):
	var group_distance = TILE_SIZE * last_group_width
	var offscreen = self.global_position.x
	var is_screen_at_last_tilegroup = ceil(fmod(offscreen, group_distance)) == 0
	var need_tile_remove = ceil(fmod(offscreen, TILE_SIZE)) == 0
	
	if is_screen_at_last_tilegroup:
		last_group_width = add_tile()
		
	if need_tile_remove:
		remove_tile(offscreen, last_group_width)
		
func remove_tile(offscreen, last_group_width):
	for y in range(-10, -1):
		print(-round(offscreen / TILE_SIZE) - last_group_width)
		set_cell(-round(offscreen / TILE_SIZE) - last_group_width * 2, y, -1)
		
func add_tile():
	var random_group_id = randi() % len(rendered_groups)
	var random_group = rendered_groups[random_group_id][0]
	var group_width = rendered_groups[random_group_id][1]
	
	for cell in random_group:
		var x_position = cell[0] + x_position_to_put_next_tile
		var y_position = cell[1]
		var tile_index = cell[2]
		set_cell(x_position, y_position, tile_index)	
	x_position_to_put_next_tile += group_width
	
	return group_width
	
