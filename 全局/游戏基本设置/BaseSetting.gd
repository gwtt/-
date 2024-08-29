extends Node

var screen_resolution_dictionary = {
	1: Vector2i(640,360),
	2: Vector2i(720,405),
	3: Vector2i(1024,576),
	4: Vector2i(1280,720),
	5: Vector2i(1600,900),
	6: Vector2i(1920,1080),
	7: Vector2i(2048,1152),
	8: Vector2i(2560,1440),
	9: Vector2i(2560,1600),
	10: Vector2i(3840,2160)
}
signal music_change()
signal sound_scape_change()
signal data_change()
var data:BaseData
var screen_size:Vector2i
func _ready():
	data = BaseData.new()
	data_change.connect(save_data)
	self.load_data()
	screen_size = DisplayServer.screen_get_size()

#设置屏幕分辨率
func set_screen_resolution(index:int) -> Vector2i:
	var temp:Vector2i = screen_resolution_dictionary.get(index)
	if temp.y > screen_size.y || index > 10:
		index = 1
	data.screen_resolution = data.screen_resolution_dictionary.get(index)
	data.screen_resolution_index = index
	DisplayServer.window_set_size(data.screen_resolution)
	BaseSetting.emit_signal("data_change")
	return data.screen_resolution

func get_screen_resolution() -> Vector2i:
	return data.screen_resolution

#设置是否全屏
func set_full_screen(is_full:bool):
	data.is_full_screen = is_full
	if data.is_full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	BaseSetting.emit_signal("data_change")	
	
func save_data():
	data.save_data()
	
func load_data():
	data.load_data()
	
