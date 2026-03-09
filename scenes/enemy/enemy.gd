extends CharacterBody2D
class_name Enemy

@export var move_speed := 400.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

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


func _on_health_component_on_damaged() -> void:
	anim_sprite.material = GameManager.HIT_MATERIAL
	await get_tree().create_timer(0.3).timeout
	anim_sprite.material = null


func _on_health_component_on_defeated() -> void:
	can_move = false
	anim_sprite.play("dead")
	collision_shape_2d.set_deferred("disabled", true)
	
	await anim_sprite.animation_finished
	GameManager.on_enemy_died.emit()
	GameManager.create_coin(global_position)
	queue_free()


func _on_hit_area_2d_body_entered(player: Player) -> void:
	player.health_component.take_damage(2)
	GameManager.play_dmage_text(player.global_position, 2)
