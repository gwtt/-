extends AudioStreamPlayer
var screen_resolution_dictionary = {
	0: -50,
	1: -20,
	2: -15,
	3: -10,
	4: -5,
	5: 0,
	6: 2,
	7: 4,
	8: 6,
	9: 8,
	10: 10
}

func _ready():
	BaseSetting.music_change.connect(change_background_music_volume)
	change_background_music_volume(BaseSetting.data.music)
	BaseSetting.sound_scape_change.connect(change_sound_scape_volume)
	change_sound_scape_volume(BaseSetting.data.sound_scape)

func change_background_music_volume(index):
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, screen_resolution_dictionary.get(index)) 

func change_sound_scape_volume(index):
	var bus_index = AudioServer.get_bus_index("音效")
	AudioServer.set_bus_volume_db(bus_index, screen_resolution_dictionary.get(index)) 
