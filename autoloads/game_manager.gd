extends Node

signal on_enemy_died

var player: Player
var coins: int = 500

const EXPLOSION_ANIM = preload("uid://bcvenaoggvsup")
const COIN = preload("uid://2qx2dr1tx5e2")
const HIT_MATERIAL = preload("uid://ckod6k03ownon")

func remove_coins(value: float) -> void:
	coins -= value
	if coins <= 0:
		coins = 0

func create_coin(pos: Vector2) -> void:
	var random_value = randf_range(0.0, 100.0)
	if random_value <= 70.0:
		var coin := COIN.instantiate()
		coin.global_position = pos
		add_child(coin)

func play_explosion_anim(pos: Vector2) -> void:
	var anim: AnimatedSprite2D = EXPLOSION_ANIM.instantiate()
	anim.global_position = pos
	anim.z_index = 99
	get_parent().add_child(anim)
	await anim.animation_finished
	anim.queue_free()
