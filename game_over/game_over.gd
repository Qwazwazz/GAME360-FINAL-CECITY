extends Control

var game: Game = load("res://scripts/game.tres")

func _ready() -> void:
	game.entered_game_menu()

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://environment/world.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
