extends Node2D

func _on_screen_entered():
	$appear_timer.start()

func _on_showtime():
	$animations.play("Appear")

func _on_head_stomp(area:Area2D):
	if area.name == "stomp_attack":
		area.owner.call("half_jump")
		self.queue_free()
