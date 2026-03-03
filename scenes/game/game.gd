extends Node2D
class_name Game

@onready var player: Player = $Player
@onready var camera: Camera2D = $Camera2D
@onready var crosshair: Sprite2D = $Crosshair

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	GameManager.player = player

func _physics_process(delta: float) -> void:
	camera.global_position = player.global_position
	var target_position = get_global_mouse_position()
	crosshair.global_position = crosshair.global_position.lerp(target_position, delta * 20)
