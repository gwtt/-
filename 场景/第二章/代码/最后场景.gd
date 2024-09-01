extends GameInit
const 关 = preload("res://场景/第二章/资源/最后场景/电灯关.png")
const 开 = preload("res://场景/第二章/资源/最后场景/电灯关.png")
const 黑色框 = preload("res://场景/第二章/资源/最后场景/黑色边框.png")
const 白色框 = preload("res://场景/第一章/资源/白色框.png")
@onready var 白框: Sprite2D = $"白色框"
@onready var 按钮: Sprite2D = $"按钮"
@onready var 眨眼: AnimatedSprite2D = $"眨眼"
@onready var 场景: Sprite2D = $"白色框/场景"
@onready var 闹钟: Sprite2D = $"闹钟底"
#分钟为单位
@onready var 灯泡开关: AudioStreamPlayer2D = $"灯泡开关"
@export var start_time:int
@export var target_time:int
@onready var 时钟十位 = $"闹钟底/上面/时钟十位"
@onready var 时钟个位 = $"闹钟底/上面/时钟个位"
@onready var 分钟十位 = $"闹钟底/上面/分钟十位"
@onready var 分钟个位 = $"闹钟底/上面/分钟个位"
@export var now_time:int:	
	set(value):
		if value > 720:
			value = 0
		now_time = value
		change_text()
#true代表开，false代表关
var state:bool = true
var finish:bool = false
signal press_button
func _ready() -> void:
	now_time = start_time
	press_button.connect(change)
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("press_button")

func change() -> void:
	灯泡开关.play()
	self.state = !self.state
	var tween = create_tween().parallel().set_ease(Tween.EASE_OUT)
	tween.tween_property(闹钟,"global_position",按钮.global_position,1)
	按钮.queue_free()
	场景.queue_free()
	白框.set_texture(黑色框)
	眨眼.modulate = Color(1,1,1,1)

#改变文字
func change_text():
	时钟十位.text = str(now_time / 60  / 10)
	时钟个位.text = str(now_time / 60 % 10)
	分钟十位.text = str(now_time % 60 / 10)
	分钟个位.text = str(now_time % 60 % 10)


func _on_timer_timeout() -> void:
	if !state:
		var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(self,"now_time",self.now_time + 60,1)
	if abs(target_time - now_time) < 120 and !finish:
		finish = true
		GlobalGameManager.emit_complete_game()
