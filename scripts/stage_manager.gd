extends Node

var cur_level : int = 0
var cur_cutscene_no : int = 1
var cur_audio_no : int = 0

const all_projectile_increase_rates : Array[float] = [
	0.05, 0.1, 0.1
]

const all_projectile_start_rate : Array[float] = [
	10, 15, 13
]

const all_bpms : Array[float] = [
	500, 480, 600
]

var level_1_melody : Array[AudioStream] = [
	load("res://sounds/song_1_intro_melody.mp3"),
	load("res://sounds/song_1_main_loop_melody.mp3"),
	load("res://sounds/song_1_main_loop_melody.mp3"),
	load("res://sounds/song_1_verse_melody.mp3"),
	load("res://sounds/song_1_main_loop_melody.mp3"),
	load("res://sounds/song_1_bridge_melody.mp3"),
	load("res://sounds/song_1_main_loop_melody.mp3"),
	load("res://sounds/song_1_outro_melody.mp3")
 ]

var level_1_backing : Array[AudioStream] = [
	load("res://sounds/song_1_intro_backing.mp3"),
	load("res://sounds/song_1_main_loop_backing.mp3"),
	load("res://sounds/song_1_main_loop_backing.mp3"),
	load("res://sounds/song_1_verse_backing.mp3"),
	load("res://sounds/song_1_main_loop_backing.mp3"),
	load("res://sounds/song_1_bridge_backing.mp3"),
	load("res://sounds/song_1_main_loop_backing.mp3"),
	load("res://sounds/song_1_outro_backing.mp3"),
]

var level_2_melody : Array[AudioStream] = [
	load("res://sounds/song_2_intro_melody.mp3"),
	load("res://sounds/song_2_chorus_melody.mp3"),
	load("res://sounds/song_2_chorus_melody.mp3"),
	load("res://sounds/song_2_verse_melody.mp3"),
	load("res://sounds/song_2_chorus_melody.mp3"),
	load("res://sounds/song_2_bridge_melody.mp3"),
	load("res://sounds/song_2_chorus_melody.mp3"),
	load("res://sounds/song_2_outro_melody.mp3")
 ]

var level_2_backing : Array[AudioStream] = [
	load("res://sounds/song_2_intro_backing.mp3"),
	load("res://sounds/song_2_chorus_backing.mp3"),
	load("res://sounds/song_2_chorus_backing.mp3"),
	load("res://sounds/song_2_verse_backing.mp3"),
	load("res://sounds/song_2_chorus_backing.mp3"),
	load("res://sounds/song_2_bridge_backing.mp3"),
	load("res://sounds/song_2_chorus_backing.mp3"),
	load("res://sounds/song_2_outro_backing.mp3"),
]

var level_3_melody : Array[AudioStream] = [
	load("res://sounds/song_3_intro_melody.mp3"),
	load("res://sounds/song_3_chorus_melody.mp3"),
	load("res://sounds/song_3_chorus_melody.mp3"),
	load("res://sounds/song_3_verse_melody.mp3"),
	load("res://sounds/song_3_chorus_melody.mp3"),
	load("res://sounds/song_3_bridge_melody.mp3"),
	load("res://sounds/song_3_chorus_melody.mp3"),
	load("res://sounds/song_3_outro_melody.mp3")
 ]

var level_3_backing : Array[AudioStream] = [
	load("res://sounds/song_3_intro_backing.mp3"),
	load("res://sounds/song_3_chorus_backing.mp3"),
	load("res://sounds/song_3_chorus_backing.mp3"),
	load("res://sounds/song_3_verse_backing.mp3"),
	load("res://sounds/song_3_chorus_backing.mp3"),
	load("res://sounds/song_3_bridge_backing.mp3"),
	load("res://sounds/song_3_chorus_backing.mp3"),
	load("res://sounds/song_3_outro_backing.mp3"),
]

var all_levels_melody : Array[Array] = [level_1_melody, level_2_melody, level_3_melody]

var all_levels_backing : Array[Array] = [level_1_backing, level_2_backing, level_3_backing]

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
	
func reset_game() -> void:
	cur_level = 0
	cur_cutscene_no = 1
	cur_audio_no = 0
	get_node("/root/Main").go_to_main__menu()
