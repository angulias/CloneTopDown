extends Node2D
class_name Game

@onready var player: Player = $Player
@onready var camera: Camera2D = $Camera2D
@onready var crosshair: Sprite2D = $Crosshair

@onready var spawner_manager: SpawnerManager = $SpawnerManager
@onready var weapons: Node2D = $Weapons
@onready var wave_label: Label = %WaveLabel
@onready var enemy_count_label: Label = %EnemyCountLabel
@onready var coins_label: Label = %CoinsLabel
@onready var wave_timer: Timer = $WaveTimer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	GameManager.player = player
	wave_timer.start()

func _physics_process(delta: float) -> void:
	camera.global_position = player.global_position
	var target_position = get_global_mouse_position()
	crosshair.global_position = crosshair.global_position.lerp(target_position, delta * 20)
	wave_label.text = "New wave in\n%d" % int(wave_timer.time_left)
	coins_label.text = str(GameManager.coins)
	enemy_count_label.text = "Enemy: %s" % str(spawner_manager.enemies_remaining)


func _on_spawner_manager_on_wave_completed() -> void:
	weapons.show()
	wave_label.show()
	enemy_count_label.hide()
	wave_timer.start()

func _on_wave_timer_timeout() -> void:
	weapons.hide()
	wave_label.hide()
	enemy_count_label.show()
	spawner_manager.start_enemy_timer()
