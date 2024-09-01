extends GameInit

@onready var 录取信息: Sprite2D = $"录取手机/录取信息"
@onready var label: Label = $"录取手机/录取信息/Label"
var origin_scale
var finish = false
func _ready() -> void:
	origin_scale = 录取信息.scale
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(录取信息,"scale",origin_scale*1.1,0.1)
		tween.tween_property(录取信息,"scale",origin_scale,0.1)
		label.visible = true
		_finish_game()
		
func _finish_game():
	if !finish:
		finish = true
		await get_tree().create_timer(3).timeout
		GlobalGameManager.emit_turn_to_next()
		print("结束游戏")
