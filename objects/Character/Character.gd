extends KinematicBody2D

signal hurt
signal dead
signal pre_dead

const GRAVITY = 9.8 * 100
var velocity = Vector2.ZERO
const JUMP_HEIGHT = 160 * 100
var can_attack = true
var is_dead = false
var is_taking_damage = false

export(AudioStreamSample) var jumping_sound
export(AudioStreamSample) var attacking_sound
export(AudioStreamSample) var taking_damage_sound
export(AudioStreamSample) var dying_sound
export(AudioStreamSample) var head_jumping_sound
	
func play_sound(stream_name):
	$audio_player.stream_paused = !Globals.is_fx_on
	$audio_player.stream = self[stream_name + "_sound"]
	$audio_player.play()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY
		if velocity.y > 30000:
			if $timer_til_die.is_stopped():
				play_sound("dying")
				$timer_til_die.start()
	else: 
		velocity.y = 0
	
	if not is_dead:
		if is_on_floor() and Input.is_action_pressed("jump"):
			self.jump()
		
		if not is_on_floor() and Input.is_action_just_released("jump"):
			self.cut_jump();

		if not is_on_floor() and Input.is_action_just_pressed("down"):
			self.fall_fast()
			
		if self.can_attack and Input.is_action_just_pressed("attack"):
			self.attack()
		
		var is_falling = velocity.y > 0
		$stomp_attack/collision.disabled = !is_falling
		
	self.move_and_slide(velocity * delta, Vector2.UP)

func jump():
	self.play_sound("jumping")
	velocity.y = -JUMP_HEIGHT
	
func head_jump():
	self.play_sound("head_jumping")
	velocity.y = -JUMP_HEIGHT
	
func fall_fast():
	velocity.y = JUMP_HEIGHT

func cut_jump():
	velocity.y = velocity.y / 1.5

func attack():
	self.play_sound("attacking")
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
	if area.owner.is_in_group("enemy"):
		area.owner.queue_free()

func hurt(): 
	if not is_taking_damage:
		is_taking_damage = true
		self.play_sound("taking_damage")
		$animation_player.play("hurt")
		Globals.lifes -= 1
		
		if Globals.lifes == 0:
			if $timer_til_die.is_stopped():
				$sprite.visible = false
				$dead_sprite.visible = true
				is_dead = true
				emit_signal("pre_dead")
				play_sound("dying")
				$timer_til_die.start()
	
		emit_signal("hurt")
	
func _on_hurt_by_area(_area): hurt()
func _on_hurt_by_body(_body): hurt()

func _on_timer_til_die_timeout():
	emit_signal("dead")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hurt":
		is_taking_damage = false
