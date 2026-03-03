extends Node2D
class_name Weapon

@export var shot_position: Vector2

@onready var weapon_sprite: Sprite2D = $WeaponSprite
@onready var fire_pos: Marker2D = $FirePos

var delay_btw_shots: float
var equiped_weapon: WeaponData

func set_up(weapon_data: WeaponData) -> void:
	equiped_weapon = weapon_data
	weapon_sprite.texture = weapon_data.weapon_sprite
	weapon_sprite.modulate = weapon_data.weapon_color
	shot_position = weapon_data.shot_position
	delay_btw_shots = weapon_data.delay_btw_shots

func rotate_weapon(value: bool) -> void:
	fire_pos.position.x = shot_position.x
	if value:
		weapon_sprite.flip_v = true
		fire_pos.position.y = shot_position.y
	else:
		weapon_sprite.flip_v = false
		fire_pos.position.y = -shot_position.y
		
