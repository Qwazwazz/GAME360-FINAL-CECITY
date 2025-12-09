extends HBoxContainer

var game: Game = load("res://Scripts/game.tres")

@onready var kills_label: Label = $KillsLabel
@onready var kills_value: Label = $KillsValue

func _ready() -> void:
	game.kills_changed.connect(update_kills_value)
	game.area_cleared.connect(next_area)
	game.reset_kills.connect(next_area)

func update_kills_value() -> void:
	kills_label.text = str("Enemies Left:")
	kills_value.text = str(15 - game.kills)

func next_area() -> void:
	kills_label.text = str("")
	kills_value.text = str("-->")

func game_won() -> void:
	update_kills_value()
