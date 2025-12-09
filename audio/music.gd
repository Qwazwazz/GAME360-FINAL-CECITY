extends AudioStreamPlayer

var game: Game = load("res://Scripts/game.tres")
const boss_music = preload("res://audio/Cecity boss music.wav")

func _ready() -> void:
	game.boss_fight.connect(change_music)

func change_music() -> void:
	self.stream = boss_music
