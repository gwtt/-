extends Node2D

@onready var 背景: Sprite2D = $"背景"
var x = 0

func _ready() -> void:
	_change_scene()

func _change_scene()->void:
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(背景,"scale",Vector2(3,3),1)
	await get_tree().create_timer(1).timeout
	tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(背景,"scale",Vector2(0,0),1)
