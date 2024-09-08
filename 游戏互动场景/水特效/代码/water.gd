extends Node2D

var pointArray=[100]
var mousePos:Vector2
@onready var blackmyth_wukong: Sprite2D = $BlackmythWukong

func _ready() -> void:
	blackmyth_wukong.material.set_shader_parameter("scale",global_scale)

func _process(delta: float) -> void:
	var time = fmod(Time.get_ticks_msec()/1000.,3600.)
	pointArray.pop_front()
	pointArray.append(Vector3(mousePos.x,mousePos.y,time))
	blackmyth_wukong.material.set_shader_parameter("mPosTime",pointArray)
	
func _input(event):
	if event is InputEventMouseMotion or event is InputEventScreenTouch:
		if event.pressure > 0:
			mousePos = event.position-global_position
