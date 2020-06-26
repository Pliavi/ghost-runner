extends Node2D

func _process(delta):
	if $end_position.global_position.x < 0:
		self.queue_free()
		
