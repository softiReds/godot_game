extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		queue_free()
		SingleGameManager.add_puntos()
