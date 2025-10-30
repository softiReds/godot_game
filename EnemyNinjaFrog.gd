extends CharacterBody2D


const SPEED = 100.0
const GRAVITY = 90.0
const JUMPPOWER = -700
var nJumps = 1

func _ready():
	$AnimatedSprite2D.play("Iddle")

func nearPlayer():
	return $Near.is_colliding()

func seePlayer():
	return $Right.is_colliding()

func move():
	velocity.x = SPEED
	$AnimatedSprite2D.play("Run")

func jump():
	if nJumps > 0:
		velocity.y = JUMPPOWER
		$AnimatedSprite2D.play("Jump")

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

func _physics_process(delta):
	velocity.y += GRAVITY
	if is_on_floor():
		nJumps = 1
		if velocity.x > 0:
			$AnimatedSprite2D.play("Run")
		elif velocity.x == 0:
			$AnimatedSprite2D.play("Iddle")
	if seePlayer():
		move()
	if nearPlayer():
		jump()
	move_and_slide()
