extends Control
class_name DmgText

@onready var dmg_label: Label = $DmgLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func set_text(value: int) -> void:
	dmg_label.text = str(value)
