extends BaseButtonStart
const first_chapter_path = "res://场景/第一章/场景/主场景.tscn"
@onready var animation = $"../../../../遮罩动画"
@export var wait_time:float = 1
func _ready():
	ResourceLoader.load_threaded_request(first_chapter_path,"",true)
	super()
	
#做个黑色渐变过场
func _on_button_up():
	if is_press:
		animation.visible = true
		var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self,"modulate",Color(1,1,1,0),wait_time)
		tween.tween_property(animation,"modulate",Color(1,1,1,1),wait_time)
		await get_tree().create_timer(wait_time).timeout
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(first_chapter_path))
