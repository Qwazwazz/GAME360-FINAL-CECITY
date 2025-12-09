extends AudioStreamPlayer

var game: Game = load("res://scripts/game.tres")
const menu_music = preload("res://audio/Cecity Main Menu.wav")
const world_music = preload("res://audio/Cecity Music.wav")
const boss_music = preload("res://audio/Cecity boss music.wav")

func _ready() -> void:
	
	change_menu_music()
	game.entered_menu.connect(change_menu_music)
	game.game_started.connect(change_world_music)
	game.boss_fight.connect(change_boss_music)

func change_boss_music() -> void:
	self.stream = boss_music
	self.play()

func change_menu_music() -> void:
	self.stream = menu_music
	self.play()

func change_world_music() -> void:
	self.stream = world_music
	self.play()
