extends GameInit
@onready var 手机灯: PointLight2D = $"手机灯"
@onready var 人: PointLight2D = $"人"
@onready var 手机壳: Sprite2D = $"手机亮"

var state = true

func _init_game():
	await get_tree().create_timer(1).timeout
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_parallel(true)
	tween.tween_property(手机灯,"color",Color(1,1,1,1),1)
	tween.tween_property(人,"color",Color(1,1,1,1),1)
	state = !state
	



func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if !state:
			GlobalGameManager.emit_complete_game()
