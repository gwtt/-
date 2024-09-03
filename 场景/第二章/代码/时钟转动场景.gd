extends GameInit

@onready var 时钟: Sprite2D = $"Sprite2D/时钟"
@onready var 分钟: Sprite2D = $"Sprite2D/分钟"
@export var 目标圈数:float = 4.0
@export var 当前圈数:float
@onready var 声音: AudioStreamPlayer2D = $"声音"
signal 完成_两圈
signal 回退_两圈
var is_over = false
var able_drag = true
var dragging = false
var mouse_start_angle = 0
var wait_time = 0
var origin_rotation:float = 0
var total_rotation:float = 0:
	set(value):
		if total_rotation != value:
			声音.set_stream_paused(false)
			wait_time = 0.015
		total_rotation = value

func _ready() -> void:
	origin_rotation = 分钟.rotation_degrees
	
func _process(delta: float) -> void:
	wait_time -= delta
	if wait_time <= 0:
		声音.set_stream_paused(true)
	if is_over:
		return
	total_rotation = total_rotation + 分钟.rotation_degrees - origin_rotation
	origin_rotation = 分钟.rotation_degrees
	时钟度数(total_rotation)

		
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !able_drag:
		dragging = false
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			dragging = true
		else:
			dragging = false
		
	if event is InputEventMouseMotion and dragging:
		分钟.look_at(get_global_mouse_position())
		分钟.rotation_degrees += 90
		
func 时钟度数(total_rotation: float):
	时钟.rotation_degrees = total_rotation * 30.0 / 360.0 * 360.0 / 目标圈数
	if int(total_rotation / 720.0) > 当前圈数:
		print("完成两圈")
		emit_signal("完成_两圈")
	if int(total_rotation / 720.0) < 当前圈数:
		print("回退两圈")
		emit_signal("回退_两圈")
	当前圈数 = int(total_rotation / 720.0)


func _on_area_2d_mouse_exited() -> void:
	dragging = false


func _on_声音_finished() -> void:
	声音.play()
