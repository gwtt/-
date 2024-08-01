extends Node2D

@onready var panel_container = $CanvasLayer/PanelContainer
@export var wait_time:float = 1

func _ready():
	panel_container.visible=true
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(panel_container,"modulate",Color(1,1,1,0),wait_time)
	await get_tree().create_timer(wait_time).timeout
	queue_free()

