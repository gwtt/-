extends GameInit

#分钟为单位
@export var start_time:int
@export var target_time:int
@onready var 时钟十位 = $"时钟十位"
@onready var 时钟个位 = $"时钟个位"
@onready var 分钟十位 = $"分钟十位"
@onready var 分钟个位 = $"分钟个位"
@export var now_time:int:	
	set(value):
		now_time = value
		change_text()

func _ready():
	now_time = start_time
#改变文字
func change_text():
	时钟十位.text = str(now_time / 60  / 10)
	时钟个位.text = str(now_time / 60 % 10)
	分钟十位.text = str(now_time % 60 / 10)
	分钟个位.text = str(now_time % 60 % 10)


func _init_game():
	await get_tree().create_timer(0.2).timeout
	var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self,"now_time",target_time,BaseSetting.move_time)
