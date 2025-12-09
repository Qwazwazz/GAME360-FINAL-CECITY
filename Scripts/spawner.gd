extends Node

const BOSS_ENEMY = preload("res://boss/boss.tscn")
const ELITE_ENEMY = preload("res://Enemies/Boss/elite.tscn")

@export var outside_enemies: Array[PackedScene]
@export var cave_enemies_1: Array[PackedScene]
@export var cave_enemies_2: Array[PackedScene]
@export var boss_arena_enemies: Array[PackedScene]

@export var outside_area: Area2D
@export var cave_area_1: Area2D
@export var cave_area_2: Area2D
@export var boss_arena: Area2D

var enemy_set: Array[PackedScene]
var current_area: Area2D

var max_enemies: = 20
var max_bosses: = 0
var max_elites: = 0

var game: Game = load("res://Scripts/game.tres")

@onready var timer: Timer = $Timer

func _ready() -> void:
	outside_area.body_entered.connect(set_area_outside)
	cave_area_1.body_entered.connect(set_area_cave_1)
	cave_area_2.body_entered.connect(set_area_cave_2)
	#boss_arena.body_entered.connect(set_area_boss_arena)
	
	
	timer.timeout.connect(func():
		
		var enemy_scenes = enemy_set
		
		var enemy_count = get_tree().get_node_count_in_group("enemies")
		if enemy_count < max_enemies and get_tree().get_node_count_in_group("active_spawn_points") > 0:
			var spawn_points = get_tree().get_nodes_in_group("active_spawn_points")
			var spawn_point = spawn_points.pick_random() as SpawnPoint
			spawn_point.spawn_enemy(enemy_scenes.pick_random())
		
		var elite_count = get_tree().get_node_count_in_group("elites")
		if elite_count < max_elites and get_tree().get_node_count_in_group("active_spawn_points") > 0:
			var spawn_points = get_tree().get_nodes_in_group("active_spawn_points")
			var spawn_point = spawn_points.pick_random() as SpawnPoint
			spawn_point.spawn_enemy(ELITE_ENEMY)
		
		var boss_count = get_tree().get_node_count_in_group("bosses")
		if boss_count < max_bosses and get_tree().get_node_count_in_group("active_spawn_points") > 0:
			var spawn_points = get_tree().get_nodes_in_group("active_spawn_points")
			var spawn_point = spawn_points.pick_random() as SpawnPoint
			spawn_point.spawn_enemy(BOSS_ENEMY)
	)

func set_area_outside(body):
	if body is Skeleton:
		current_area = outside_area
		enemy_set = outside_enemies

func set_area_cave_1(body):
	if body is Skeleton:
		current_area = cave_area_1
		enemy_set = cave_enemies_1
		max_elites = 1

func set_area_cave_2(body):
	if body is Skeleton:
		current_area = cave_area_2
		enemy_set = cave_enemies_2
		max_elites = 2

func set_area_boss_arena(body):
	if body is Skeleton:
		current_area = boss_arena
		enemy_set = boss_arena_enemies
		max_bosses = 1
		max_elites = 3
