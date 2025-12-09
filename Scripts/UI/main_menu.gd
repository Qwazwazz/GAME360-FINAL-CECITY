extends Control

var game: Game = load("res://scripts/game.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game.entered_game_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://environment/world.tscn")


func _on_options_2_pressed() -> void:
	print ("options pressed")


func _on_Quit_3_pressed() -> void:
	get_tree().quit()
