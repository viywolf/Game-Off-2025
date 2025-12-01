extends Node2D

@onready var cur_song : int = 1
@onready var cur_bpm : float = 300

@export var game_paused : bool = false

var health_cooldown : bool = false
var next_backing_ready : bool = true

var cur_note_count : int = 0

signal go_to_cutscene

"""
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		#$Path2D/Spawnpoint.spawn_note_projectile()
		$Path2D/Spawnpoint.spawn_note_projectile()
		$WavePath2D/WaveSpawnpoint.spawn_wave()
"""

func _ready() -> void:
	$AudioStreamPlayer.stream = Stage.get_current_backing()
	$AudioStreamPlayer.play()
	if(game_paused == false):
		$Path2D/Spawnpoint.start_playing = true
	else:
		$Path2D/Spawnpoint.start_playing = false
	$Path2D/Spawnpoint.song_over.connect(next_step)
	$Path2D/Spawnpoint.next_section_availiable.connect(prepare_next_backing)
	$Path2D/Spawnpoint.health_reduced.connect(reduce_health)
	$Path2D/Spawnpoint.note_played.connect(spawn_wave_if__can)
	$WavePath2D/WaveSpawnpoint.health_reduced.connect(reduce_health)
	$Camera2D/Hearts.player_dead.connect(dead_screen)

func _process(delta: float) -> void:
	if(health_cooldown == true):
		await get_tree().create_timer(0.1).timeout
		health_cooldown = false
	if(next_backing_ready):
		$AudioStreamPlayer.stream = Stage.get_current_backing()
		$AudioStreamPlayer.play()
		next_backing_ready = false

func change_backing() -> void:
	pass
	#await get_tree().create_timer(0.005).timeout
	#$AudioStreamPlayer.stream = Stage.get_current_backing()
	#$AudioStreamPlayer.play()

func _on_audio_stream_player_finished() -> void:
	change_backing()
	
func next_step() -> void:
	# change this to call main
	go_to_cutscene.emit()
	#var cutscene_scene : PackedScene = load("res://scenes/cutscene.tscn")
	#var new_cutscene = cutscene_scene.instantiate()
	#new_cutscene.current_scene = Stage.cur_level + 1
	Stage.next_level()
	queue_free()
	
func prepare_next_backing() -> void:
	next_backing_ready = true
	
func reduce_health() -> void:
	print("check if can reduce health")
	if(health_cooldown == false):
		health_cooldown = true
		await get_tree().create_timer(0.005).timeout
		print("-1 health")
		$HitSound.play()
		$Camera2D/Hearts.reduce_heart()
		$Camera2D/Hearts.update_hearts()

func spawn_wave_if__can() -> void:
	cur_note_count += 1
	if(cur_note_count % 8 == 0):
		$WavePath2D/WaveSpawnpoint.spawn_wave()

func dead_screen() -> void:
	print("oh no you died")
	$DeadSound.play()
	next_step()
