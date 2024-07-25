extends Node2D

var targetPos: Vector2
var direction: Vector2
@export var speed: float = 500
@export var curve: Curve
var total_distance: float
var current_distance: float
var player_sprite: Sprite2D

func _ready():
	player_sprite = get_node("Icon")

func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		targetPos = get_global_mouse_position()
		direction = position.direction_to(targetPos)
		total_distance = global_position.distance_to(targetPos)
		current_distance = 0;

	if position.distance_to(targetPos) > 5:
		current_distance = current_distance + (float)(delta) * speed
		var scale = current_distance / total_distance
		var curveY = curve.sample(scale)
		global_position = global_position + direction * speed * (float)(delta)
		#移动玩家图标，最后乘以(totalDistance / 1000) 是为了考虑不同距离的振幅强弱
		player_sprite.position = Vector2(0, -curveY * 100 * (total_distance / 1000));
