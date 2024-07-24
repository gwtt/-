extends AnimatedSprite2D

@export var scale_x:float = 0.1
@export var scale_y:float = 0.1

func _ready():
	set_scale(Vector2(scale_x,scale_y))

func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)	

func _physics_process(delta):
	position = get_global_mouse_position()

#如果按着
func _input(event):
	if event is InputEventMouse and event.get_button_mask() == MOUSE_BUTTON_MASK_LEFT:
		play("点击")
	else:
		play("默认")
