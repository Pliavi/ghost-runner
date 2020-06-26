extends KinematicBody2D

const GRAVITY = 9.8 * 100
var velocity = Vector2.ZERO
const JUMP_HEIGHT = 160 * 100

func _physics_process(delta):
	if is_on_floor() and Input.is_action_pressed("jump"):
		self.jump()
		
	if not is_on_floor():
		velocity.y += GRAVITY
		
	self.move_and_slide(velocity * delta, Vector2.UP)

func jump():
	velocity.y = -JUMP_HEIGHT
