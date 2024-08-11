extends Sprite2D

var count = 0
var time = 0;

var is_drag = false
#表示是否结束
var is_over = false
#是否是下限
var is_down_limit = false
#是否是上限
var is_up_limit = false
var is_force_to = false
#滚轮速度
@export var velocity = 20
var OFFSET_Y = 0
@export var y = 50;
@export var change_time = 0.1
func _process(delta):
	if count > 0:
		time += delta
		if count > 5 and !is_over:
			is_over = true
			await get_tree().create_timer(0.1).timeout
			GlobalGameManager.emit_complete_game()
		if time > 20 and !is_over:
			GlobalGameManager.emit_complete_game()
			is_over = true
	if is_drag and !is_over:
		if is_down_limit:
			if (get_global_mouse_position().y + OFFSET_Y) > self.global_position.y:
				is_force_to = true
				is_drag = false
				var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				tween.tween_property(self,"global_position",Vector2(self.global_position.x,self.global_position.y-y),change_time)
				tween.tween_property(self,"is_force_to",false,change_time)
				return
		if is_up_limit:
			if (get_global_mouse_position().y + OFFSET_Y) < self.global_position.y:
				is_force_to = true
				is_drag = false
				var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				tween.tween_property(self,"global_position",Vector2(self.global_position.x,self.global_position.y+y),change_time)
				tween.tween_property(self,"is_force_to",false,change_time)	
				return
		self.global_position.y = get_global_mouse_position().y + OFFSET_Y

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		if event.pressure > 0.0 and !is_force_to:
			OFFSET_Y = self.global_position.y - get_global_mouse_position().y
			is_drag = true
		else:
			is_drag = false
	if event is InputEventMouseButton:
		if !is_force_to:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if is_up_limit:
					is_force_to = true
					var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
					tween.tween_property(self,"global_position",Vector2(self.global_position.x,self.global_position.y+y),change_time)
					tween.tween_property(self,"is_force_to",false,change_time)
					return
				self.global_position.y = self.global_position.y - velocity
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if is_down_limit:
					is_force_to = true
					var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
					tween.tween_property(self,"global_position",Vector2(self.global_position.x,self.global_position.y-y),change_time)
					tween.tween_property(self,"is_force_to",false,change_time)	
					return
				self.global_position.y = self.global_position.y + velocity
func _on_上限_area_entered(area):
	is_up_limit = true

func _on_上限_area_exited(area):
	is_up_limit = false

func _on_下限_area_entered(area):
	is_down_limit = true

func _on_下限_area_exited(area):
	is_down_limit = false
