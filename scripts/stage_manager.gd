extends Node

var cur_level : int = 0
var cur_cutscene_no : int = 1
var cur_audio_no : int = 0

var all_bpms : Array[float] = [
	500,
]

var level_1_melody : Array[AudioStream] = [
	load("res://sounds/song_1_intro_melody.mp3"),
	load("res://sounds/song_1_main_loop_melody.mp3"),
	load("res://sounds/song_1_main_loop_melody.mp3"),
	load("res://sounds/song_1_main_loop_melody.mp3"),
	load("res://sounds/song_1_outro_melody.mp3")
 ]

var level_1_backing : Array[AudioStream] = [
	load("res://sounds/song_1_intro_backing.mp3"),
	load("res://sounds/song_1_main_loop_backing.mp3"),
	load("res://sounds/song_1_main_loop_backing.mp3"),
	load("res://sounds/song_1_main_loop_backing.mp3"),
	load("res://sounds/song_1_outro_backing.mp3"),
]

var all_levels_melody : Array[Array] = [level_1_melody]

var all_levels_backing : Array[Array] = [level_1_backing]

func get_current_melody() -> AudioStream:
	return all_levels_melody[cur_level][cur_audio_no]

func get_current_backing() -> AudioStream:
	#if(cur_audio_no > all_levels_backing[cur_level].size()):
	#	return all_levels_backing[cur_level][cur_audio_no % all_levels_backing[cur_level].size()]
	return all_levels_backing[cur_level][cur_audio_no]
	
func next_audio_no() -> bool:
	if(cur_audio_no + 1 >= all_levels_melody[cur_level].size()):
		return false
	else:
		cur_audio_no += 1
		return true

func next_level() -> void:
	cur_level += 1
