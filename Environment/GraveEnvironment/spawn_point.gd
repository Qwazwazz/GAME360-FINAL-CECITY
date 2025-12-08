class_name SpawnPoint extends Node2D

@export var activation_area: Area2D
@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var player_inside := false

func _ready():
	if activation_area:
		activation_area.body_entered.connect(_on_body_entered)
		activation_area.body_exited.connect(_on_body_exited)

	notifier.screen_entered.connect(_on_screen_entered)
	notifier.screen_exited.connect(_on_screen_exited)

	_update_group_state()


func _on_body_entered(body):
	if body is Skeleton:
		print("Player has entered the spawning area")
		player_inside = true
		_update_group_state()

func _on_body_exited(body):
	if body is Skeleton:
		print("Player has left the spawning area")
		player_inside = false
		_update_group_state()


func _on_screen_entered():
	_update_group_state()

func _on_screen_exited():
	_update_group_state()


func _update_group_state():
	# Active if player inside AND off-screen
	if player_inside and !notifier.is_on_screen():
		add_to_group("active_spawn_points")
	else:
		remove_from_group("active_spawn_points")


func spawn_enemy(enemy_scene: PackedScene):
	var enemy = enemy_scene.instantiate()
	enemy.global_position = global_position
	get_tree().current_scene.add_child(enemy)
