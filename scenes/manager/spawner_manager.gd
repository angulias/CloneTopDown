extends Node
class_name SpawnerManager

const SPAWN_ANIM = preload("uid://b2klf44s1kcgj")

enum SpawnType{
	RandomTimer,
	FixedTimer
}

@export var spawn_type: SpawnType
@export var min_random: float
@export var max_random: float
@export var fixed_timer: float
@export var enemies_per_wave := 5

@export var enemy_list: Array[PackedScene] = []

@onready var timer: Timer = $Timer

var enemies_remaining: int
var spawned_enemies: int

func _ready() -> void:
	start_enemy_timer()

func spawn_enemy() -> void:
	var spawn_anim: SpawnAnim = SPAWN_ANIM.instantiate()
	var pos_x = randf_range(-1000, 1000)
	var pos_y = randf_range(-1000, 1000)
	var spawn_pos := Vector2(pos_x, pos_y)
	spawn_anim.global_position = spawn_pos
	add_child(spawn_anim)
	
	await spawn_anim.on_spawn_enemy
	spawn_anim.queue_free()
	
	var random_enemy = enemy_list.pick_random() as PackedScene
	var enemy = random_enemy.instantiate()
	enemy.global_position = spawn_pos
	add_child(enemy)
	
	spawned_enemies += 1
	start_enemy_timer()

func start_enemy_timer() -> void:
	timer.wait_time = get_new_timer()
	timer.start()

func get_new_timer() -> float:
	var time: float
	if spawn_type == SpawnType.RandomTimer:
		time = randf_range(min_random, max_random)
	else:
		time = fixed_timer
	return time


func _on_timer_timeout() -> void:
	if spawned_enemies >= enemies_per_wave:
		return
	
	spawn_enemy()
