extends Node2D
@onready var cherry = load("res://collectible.tscn")
var timer

func _ready():
	#timer = get_node("Timer")
	#timer.stop
	#timer.wait_time = randf_range(3,5)
	#timer.start()
	pass

func spawn():
	var inst = cherry.instatiate()
	add_child(inst)

func _on_timer_out():
	spawn()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	pass # Replace with function body.
