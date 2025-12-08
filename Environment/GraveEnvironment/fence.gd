extends StaticBody2D

var game: Game = load("res://Scripts/game.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.kills_changed.connect(destroy_gate)


func destroy_gate() -> void:
	if game.kills == 15:
		queue_free()
