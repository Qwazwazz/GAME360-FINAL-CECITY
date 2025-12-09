extends HBoxContainer

var game: Game = load("res://Scripts/game.tres")

@onready var kills_label: Label = $KillsLabel
@onready var kills_value: Label = $KillsValue

func _ready() -> void:
	var scene_name = get_tree().current_scene.name
	
	if scene_name == "GameOver" or scene_name == "GameWin":
		update_kills_value()
	else:
		next_area()
	
	game.kills_changed.connect(update_enemies_left)
	game.show_final_kills.connect(update_kills_value)
	game.area_cleared.connect(next_area)
	game.reset_kills.connect(next_area)

func update_kills_value() -> void:
	kills_label.text = str("Kills:")
	kills_value.text = str(game.kills)

func update_enemies_left() -> void:
	kills_label.text = str("Enemies Left:")
	kills_value.text = str(15 - game.kills)

func next_area() -> void:
	kills_label.text = str("")
	kills_value.text = str("GO! -->")

func game_won() -> void:
	update_kills_value()
