extends CharacterBody2D
class_name Enemy

@export var move_speed := 400.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var can_move :=  true

func _process(delta: float) -> void:
	# obtenemos un vector hacia el jugador de esta manera
	var player_dir := GameManager.player.global_position - global_position
	var direction := player_dir.normalized()
	
	var movement = direction * move_speed
	velocity = movement
	
	if not can_move:
		return
	
	if player_dir.length() <= 150:
		return
	
	move_and_slide()
	anim_sprite.flip_h = true if velocity.x < 0 else false
