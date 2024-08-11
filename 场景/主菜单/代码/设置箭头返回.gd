extends BaseButtonClick
#开始界面
@export var start_panel:Control
#自己在的panel
@export var own_panel:Control
@export var 书籍翻页:AudioStreamPlayer

func _ready():
	own_panel.visible = false
	own_panel.modulate = Color(1,1,1,0)
	super()

func on_button_up():
	书籍翻页.play()
	super()
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(own_panel,"modulate",Color(1,1,1,0),0.2)
	tween.tween_property(start_panel,"modulate",Color(1,1,1,1),0.2)
	tween.tween_property(own_panel,"visible",false,0.2)
	tween.tween_property(start_panel,"visible",true,0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.2)
