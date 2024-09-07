extends Sprite2D
@onready var sprite = $"."
var flip_progress = 0.0

func _ready():
	sprite.material.set_shader_parameter("flip_progress", flip_progress)

func _process(delta):
	# 这里可以添加逻辑来改变flip_progress的值
	# 例如，根据用户输入或其他事件来改变
	flip_progress += delta * 0.1
	sprite.material.set_shader_parameter("flip_progress", flip_progress)
