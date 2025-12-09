extends CharacterBody2D

const HIT_BURST_PARTICLE = preload("res://effects/hit_burst_effect.tscn")
const FODDER_BURST_PARTICLE = preload("res://effects/fodder_burst_effect.tscn")
const FODDER_SPAWN = preload("res://enemies/floaty/floater.tscn")

var game: Game = load("res://scripts/game.tres")

@export var walk_speed: = 80.0
@export var attack_range: = 32.0
@export var retreat_range: = 25.0
@export var stats: Stats

@onready var healthbar: ProgressBar = $Healthbar
@onready var anchor: Node2D = $Anchor

@onready var hit_sound_effect: AudioStreamPlayer = $HitSoundEffect
@onready var skeleton_targeter: SkeletonTargeter = $SkeletonTargeter
@onready var hurtbox: Hurtbox = $Anchor/Hurtbox
@onready var hitbox: Hitbox = $Anchor/Hitbox
@onready var effect_marker_2d: Marker2D = $EffectMarker2D
@onready var unit_mover: UnitMover = $UnitMover
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")

func _ready() -> void:
	stats = stats.duplicate()
	healthbar.stats = stats
	hurtbox.hurt.connect(_on_hurt.call_deferred)

func _physics_process(delta: float) -> void:
	#if position.y <= -50: queue_free()
	#if position.x <= -50 or position.x >= 1394: queue_free()
	
	var state = playback.get_current_node()
	match state:
		"ChaseState":
			walk_speed = 80.0
			var input_x: float = skeleton_targeter.get_direction_to_skeleton()
			if input_x != 0.0:
				unit_mover.apply_flip(-input_x)
				velocity.x = input_x * walk_speed
			move_and_slide()
		"RetreatState":
			walk_speed = 120.0
			
			var input_x: float = -skeleton_targeter.get_direction_to_skeleton()
			if input_x != 0.0:
				unit_mover.apply_flip(-input_x)
				velocity.x = input_x * walk_speed
			move_and_slide()
		"AttackState":
			pass
		"HitState":
			unit_mover.apply_friction(delta, unit_mover.hit_friction * 0.01)
			move_and_slide()

func die() -> void:
	spawn_underling()
	
	game.kills += 1
	queue_free()

func _on_hurt(other_hitbox: Hitbox) -> void:
	#hit_sound_effect.play()
	var hit_burst_particle = HIT_BURST_PARTICLE.instantiate()
	get_tree().current_scene.add_child(hit_burst_particle)
	var previous_health = stats.health
	hit_burst_particle.global_position = effect_marker_2d.global_position
	stats.health -= other_hitbox.damage
	unit_mover.apply_knockback(other_hitbox)
	if previous_health > 0:
		playback.start("HitState")
	
	if stats.health <= 0 and previous_health > 0: 
		game.kills += 1
		playback.travel("DieState")

func spawn_underling() -> void:
	var fodder_burst_effect = FODDER_BURST_PARTICLE.instantiate()
	get_tree().current_scene.add_child(fodder_burst_effect)
	fodder_burst_effect.global_position = effect_marker_2d.global_position
	
	var fodder_spawn = FODDER_SPAWN.instantiate()
	get_tree().current_scene.add_child(fodder_spawn)
	fodder_spawn.global_position = anchor.global_position
