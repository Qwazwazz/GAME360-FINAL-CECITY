extends Node

const BOSS_ENEMY = preload("res://Enemies/Boss/elite.tscn")

@export var enemy_scenes: Array[PackedScene]

var max_enemies: = 15
var max_bosses: = 1

var game: Game = load("res://Scripts/game.tres")

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(func():
		
		var enemy_count = get_tree().get_node_count_in_group("enemies")
		if enemy_count < max_enemies and get_tree().get_node_count_in_group("active_spawn_points") > 0:
			var spawn_points = get_tree().get_nodes_in_group("active_spawn_points")
			var spawn_point = spawn_points.pick_random() as SpawnPoint
			spawn_point.spawn_enemy(enemy_scenes.pick_random())
		
		var boss_count = get_tree().get_node_count_in_group("bosses")
		if boss_count < max_bosses and game.kills >= 15  and get_tree().get_node_count_in_group:
			var spawn_points = get_tree().get_nodes_in_group("active_spawn_points")
			var spawn_point = spawn_points.pick_random() as SpawnPoint
			spawn_point.spawn_enemy(BOSS_ENEMY)
	)
