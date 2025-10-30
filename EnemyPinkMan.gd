extends CharacterBody2D


const SPEED = 100.0
const GRAVITY = 980.0

func _ready():
	velocity.x = SPEED
	$AnimatedSprite2D.play("Run")

func _next_to_left_wall():
	return $Left.is_colliding()

func _next_to_right_wall():
	return $Right.is_colliding()

func flip():
	if _next_to_left_wall() or _next_to_right_wall():
		velocity.x *= -1
		$AnimatedSprite2D.scale.x *= 1

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
	flip()
	move_and_slide()
