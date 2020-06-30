extends KinematicBody2D

signal hurt
signal dead

const GRAVITY = 9.8 * 100
var velocity = Vector2.ZERO
const JUMP_HEIGHT = 160 * 100
var can_attack = true

func _physics_process(delta):
	var is_falling = velocity.y > 0
	
	$stomp_attack/collision.disabled = !is_falling
		
	if is_on_floor() and Input.is_action_pressed("jump"):
		self.jump()
		
	if self.can_attack and Input.is_action_just_pressed("attack"):
		self.attack()
		
	if not is_on_floor():
		velocity.y += GRAVITY
		print(velocity.y)
		if velocity.y > 30000:
			emit_signal("dead")
		
	self.move_and_slide(velocity * delta, Vector2.UP)

func jump():
	velocity.y = -JUMP_HEIGHT
	
func half_jump():
	velocity.y = -JUMP_HEIGHT/2
	
func attack():
	self.can_attack = false
	$Slash/cooldown.start()
	$Slash.visible = true
	$Slash/animation.frame = 0
	$Slash/animation.play()
	$Slash/collision.disabled = false
	
func _on_attack_animation_finished():
	$Slash.visible = false
	$Slash/collision.disabled = true

func _on_cooldown_finish():
	self.can_attack = true

func _on_slash_area(area):
	area.owner.queue_free()

func hurt(): emit_signal("hurt")
func _on_hurt_by_area(area): hurt()
func _on_hurt_by_body(body): hurt()
