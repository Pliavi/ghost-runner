extends KinematicBody2D

const GRAVITY = 9.8 * 100
var velocity = Vector2.ZERO
const JUMP_HEIGHT = 150 * 100

func _process(delta):
	if is_on_floor() and Input.is_action_pressed("jump"):
		jump(delta)
	
	velocity.y += GRAVITY
	move_and_slide(velocity * delta, Vector2.UP)

func jump(delta):
	velocity.y = -JUMP_HEIGHT
