extends BaseButtonStart

const first_chapter_path = "res://场景/第一章/场景/主场景.tscn"
@export var wait_time:float = 1
func _on_button_up():
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"modulate",Color(1,1,1,0),wait_time)
	await get_tree().create_timer(wait_time).timeout
	get_tree().change_scene_to_file(first_chapter_path)
