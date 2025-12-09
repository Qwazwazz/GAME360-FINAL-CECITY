extends StaticBody2D

var game: Game = load("res://Scripts/game.tres")

@export var battle_area: Node
@export var area_collision: Area2D

var skeleton_present = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_collision.body_entered.connect(skeleton_entered_area)
	area_collision.body_exited.connect(skeleton_exited_area)
	game.kills_changed.connect(destroy_gate)


func destroy_gate() -> void:
	if game.kills == 15 and skeleton_present == true:
		var all_enemies = get_tree().get_nodes_in_group("enemies")
		
		for node in all_enemies:
			node.queue_free()
		game.reset_ui_kills()
		battle_area.queue_free()

func skeleton_entered_area(body):
	if body is Skeleton:
		skeleton_present = true

func skeleton_exited_area(body):
	if body is Skeleton:
		skeleton_present = false
