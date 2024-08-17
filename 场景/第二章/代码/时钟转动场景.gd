extends GameInit

@onready var 时钟: Sprite2D = $"Sprite2D/时钟"
@onready var 分钟: Sprite2D = $"Sprite2D/分钟"
@export var 目标圈数:float
@export var 当前圈数:float

var dragging = false
var mouse_start_angle = 0
var origin_rotation:float = 0
var total_rotation:float = 0
func _ready() -> void:
	origin_rotation = 分钟.rotation_degrees
func _process(delta: float) -> void:
	if 当前圈数 > 目标圈数:
		complete_game()
		
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			dragging = true
		else:
			dragging = false
			
	if event is InputEventMouseMotion and dragging:
		分钟.look_at(event.position)
		分钟.rotation_degrees += 90
		total_rotation = total_rotation + 分钟.rotation_degrees - origin_rotation
		时钟度数(total_rotation)
		origin_rotation = 分钟.rotation_degrees
		
func 时钟度数(total_rotation: float):
	时钟.rotation_degrees = total_rotation * 30.0 / 360.0
