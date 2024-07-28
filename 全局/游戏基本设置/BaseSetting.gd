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
#音效 todo还要加个信号判断
var sound_scape:int = 6:
	set(value):
		if value > 10:
			sound_scape = 0
		else:
			sound_scape =  value
#音乐 todo还要加个信号判断
var music:int = 2:
	set(value):
		if value > 10:
			music =  0
		else:
			music =  value
		emit_signal("music_change",music)
#是否全屏
var is_full_screen:bool = false
#默认分辨率
var screen_resolution_index:int = 6
var screen_resolution:Vector2 = screen_resolution_dictionary.get(6)
var screen_size:Vector2i
func _ready():
	#todo 读取文件配置相关，初始化数组
	screen_size = DisplayServer.screen_get_size()
	pass

#设置屏幕分辨率
func set_screen_resolution(index:int) -> Vector2i:
	var temp:Vector2i = screen_resolution_dictionary.get(index)
	if temp.y > screen_size.y || index > 10:
		index = 1
	screen_resolution = screen_resolution_dictionary.get(index)
	screen_resolution_index = index
	DisplayServer.window_set_size(screen_resolution)
	return screen_resolution

#设置是否全屏
func set_full_screen():
	is_full_screen = !is_full_screen
	if is_full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

