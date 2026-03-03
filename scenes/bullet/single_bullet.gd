extends Node2D
class_name Bullet

@export var speed := 1000.0
@onready var explosion_sound: AudioStreamPlayer = $ExplosionSound

var move_direction : Vector2
var damage: float

func _process(delta: float) -> void:
	if move_direction == Vector2.ZERO:
		return
	
	position += move_direction * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.play_explosion_anim(global_position)
	await get_tree().create_timer(0.08).timeout
	explosion_sound.play()
	queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
