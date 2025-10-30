extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D
@onready var timer = $Timer
@onready var cam = $Camera2D2
@onready var timer_2: Timer = $Timer2
@onready var jump_label

var accum = 0
var itera = 0
var conta = 0
var maxim = 160
var steps = 40

func _ready():
	jump_label = get_node("/root/Ui/Sprite2D2/JumpLabel")

func CameraMove():
	itera = 0
	conta = 0
	accum = 0
	timer_2.start()
	cam.drag_horizontal_enabled = false

func _on_timer_cam_timeout():
	if ( itera <= maxim ):
		accum = -20 + accum
		cam.position = Vector2( accum, 0 )
		itera = itera + 1
	if ( itera > 25 ):
		if ( cam.position < Vector2(0,0) ):
			accum = 20 + accum
			cam.position = Vector2( accum, 0 )
		conta = conta + 1
		if ( conta == 26 ):
			timer_2.stop()
			cam.drag_horizontal_enabled = true

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Recorrido"): 
		CameraMove()
	if ( velocity.x > 1 || velocity.x < -1 ): 
		sprite_2d.animation = 'Running'
	else:
		sprite_2d.animation = 'Breathing'
	if Input.is_action_just_pressed("zoomIn"): 
		if(cam.zoom<=Vector2(2,2)):
			cam.zoom=cam.zoom+Vector2(.5,.5)
	if Input.is_action_just_pressed("zoomOut"): 
		if(cam.zoom>=Vector2(.5,.5)):
			cam.zoom=cam.zoom-Vector2(.5,.5)

	# Add the gravity.	if not is_on_floor():
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "Jump"
	
	if(is_on_floor()):	
		jump_label.text = str(2)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or timer.time_left>0.0):
		velocity.y = JUMP_VELOCITY
		jump_label.text = str(int(jump_label.text) - 1)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y>=0
	
	if just_left_ledge:
		timer.start()

	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft


func _on_timer_2_timeout() -> void:
	pass # Replace with function body.
