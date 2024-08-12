extends Button

@export var angle_x_max: float = 15.0
@export var angle_y_max: float = 15.0
@export var max_offset_shadow: float = 50.0

var tween_rot: Tween
var tween_hover: Tween
var tween_flip: Tween
var tween_destroy: Tween

var is_flip = true

@onready var shadow = $Shadow
@onready var card_texture = $CardTexture
@onready var card_back = $CardBack
@onready var root = $".."

func _ready() -> void:
	#调整格式
	angle_x_max = deg_to_rad(angle_x_max)
	angle_y_max = deg_to_rad(angle_y_max)

func _process(delta: float) -> void:
	handle_shadow(delta)
	
func handle_shadow(delta: float) -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var distance: float = global_position.x - center.x
	
	shadow.position.x = lerp(0.0, -sign(distance) * max_offset_shadow, abs(distance/(center.x)))

func _on_gui_input(event: InputEvent) -> void:
	#鼠标悬停旋转
	var mouse_pos: Vector2 = get_local_mouse_position()
	var diff: Vector2 = (position + size) - mouse_pos

	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)

	var rot_x: float = rad_to_deg(lerp_angle(-angle_x_max, angle_x_max, lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(angle_y_max, -angle_y_max, lerp_val_y))
	if !is_flip:
		card_texture.material.set_shader_parameter("x_rot", rot_y)
		card_texture.material.set_shader_parameter("y_rot", rot_x)

func _on_mouse_entered() -> void:
	print("hello")
	#设置缩放
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(1.2, 1.2), 0.5)
func _on_mouse_exited() -> void:
	#重置旋转角度
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	if !is_flip:
		tween_rot.tween_property(card_texture.material, "shader_parameter/x_rot", 0.0, 0.5)
		tween_rot.tween_property(card_texture.material, "shader_parameter/y_rot", 0.0, 0.5)
	#重置缩放
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.55)

func _on_mouse_pressed():
	self.set_disabled(true)
	root.count_card += 1
	if root.count_card == 2:
		root._limit_child(true)
	if tween_flip and tween_flip.is_running():
		tween_flip.kill()
	tween_flip = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_flip.tween_property(card_back.material, "shader_parameter/y_rot", 90, 0.05)
	tween_flip.tween_property(card_texture.material, "shader_parameter/y_rot", 0, 0.5)
	await get_tree().create_timer(2).timeout
	is_flip = false
	root._append_card(self)
	
func _flip():
	if tween_flip and tween_flip.is_running():
		tween_flip.kill()
	tween_flip = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_flip.tween_property(card_texture.material, "shader_parameter/y_rot", -90, 0.05)
	tween_flip.tween_property(card_back.material, "shader_parameter/y_rot", 0, 0.5)
	is_flip = true
	self.set_disabled(false)
	
func _destroy():
	card_texture.use_parent_material = true
	if tween_destroy and tween_destroy.is_running():
		tween_destroy.kill()
	tween_destroy = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_destroy.tween_property(material, "shader_parameter/dissolve_value", 0.0, 2.0).from(1.0)
	tween_destroy.parallel().tween_property(shadow, "self_modulate:a", 0.0, 1.0)
	
func _if_can_not_pressed(boolean):
	self.set_disabled(boolean)
