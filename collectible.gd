extends Area2D
var coin_sound

func _ready():
	coin_sound = get_node("/root/Node/CoinSound")

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		SingleGameManager.add_puntos()
 		coin_sound.playing = true
		queue_free()
