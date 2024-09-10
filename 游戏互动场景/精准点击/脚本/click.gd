extends Node2D

@onready var right: Node2D = $blue/right
@onready var left: Node2D = $blue/left
@onready var arrow: Sprite2D = $"Arrow-removebg-preview"
@onready var area: Area2D = $"Arrow-removebg-preview/箭头"
@onready var collision_shape_2d: CollisionShape2D = $"Arrow-removebg-preview/箭头/CollisionShape2D"

var is_in = false
var tween_left: Tween
var tween_right: Tween

func _ready() -> void:
	arrow.global_position.x = left.global_position.x

func _process(delta: float) -> void:
	if arrow.global_position.x == left.global_position.x:
		tween_left = create_tween()
		tween_left.tween_property(arrow,"global_position",Vector2(right.global_position.x,arrow.global_position.y),3)
	if arrow.global_position.x == right.global_position.x:
		tween_right = create_tween()
		tween_right.tween_property(arrow,"global_position",Vector2(left.global_position.x,arrow.global_position.y),3)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and is_in:
			print("win")
			if(tween_left and tween_left.is_running()):
				tween_left.kill()
			if(tween_right and tween_right.is_running()):
				tween_right.kill()
			await get_tree().create_timer(2).timeout
			_ready()

func _on_条子_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	is_in = true

func _on_条子_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	is_in = false
