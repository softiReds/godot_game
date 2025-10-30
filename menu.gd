extends Node
var ui_node

func _ready():
	ui_node = get_node("/root/Ui")
	ui_node.hide()

func _exit_tree():
	ui_node.show()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nivel2.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://nivel1.tscn")
