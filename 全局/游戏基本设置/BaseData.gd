class_name BaseData
extends Resource

const SAVE_GAME_PATH = "user://save.tres"
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
@export var move_time:float = 2.0
@export var origin_time:float = 2.0
#音效 todo还要加个信号判断
@export var sound_scape:int = 6:
	set(value):
		if value > 10:
			sound_scape = 0
		else:
			sound_scape =  value
		BaseSetting.emit_signal("sound_scape_change",sound_scape)
		BaseSetting.emit_signal("data_change")
#音乐 todo还要加个信号判断
@export var music:int = 2:
	set(value):
		if value > 10:
			music =  0
		else:
			music =  value
		BaseSetting.emit_signal("music_change",music)
		BaseSetting.emit_signal("data_change")
#是否全屏
@export var is_full_screen:bool = false:
	set(value):
		is_full_screen = value
		if is_full_screen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
#默认分辨率
@export var screen_resolution_index:int = 6:
	set(value):
		screen_resolution_index = value
@export var screen_resolution:Vector2 = screen_resolution_dictionary.get(6):
	set(value):
		screen_resolution = value
		DisplayServer.window_set_size(screen_resolution)
func save_data():
	ResourceSaver.save(self,SAVE_GAME_PATH)
	
func load_data():
	var save_data = ResourceLoader.load(SAVE_GAME_PATH,"")
	if save_data:
		move_time = save_data.move_time
		origin_time = save_data.origin_time
		sound_scape = save_data.sound_scape
		music = save_data.music
		is_full_screen = save_data.is_full_screen
		screen_resolution_index = save_data.screen_resolution_index
		screen_resolution = save_data.screen_resolution
