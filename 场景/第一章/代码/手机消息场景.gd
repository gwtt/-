extends GameInit

@onready var 消息 = $"白色框/蒙板/消息"
@export var change_time = 8.0

func _init_game():
	await get_tree().create_timer(0.5).timeout
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(消息,"position",Vector2(0,0),change_time)
	await get_tree().create_timer(change_time + 1).timeout
	GlobalGameManager.emit_turn_to_next()
