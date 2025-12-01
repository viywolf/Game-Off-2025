extends PathFollow2D

@onready var note_projectile_scene : PackedScene = preload("res://scenes/note_projectile.tscn")
var new_note : Node
var cur_count : int = 0
var new_note_ready : bool = 1

var projectile_per_no : float = 10

@export var start_playing : bool = false

signal health_reduced
signal song_over
signal next_section_availiable
signal note_played

func _process(delta: float) -> void:
	if(start_playing == true):
		projectile_per_no += 0.3 * delta
		if(projectile_per_no <= 1):
			projectile_per_no = 1
		if(new_note_ready == true):
			new_note = note_projectile_scene.instantiate()
			if(cur_count % int(projectile_per_no) == 0):
				new_note.send_note_projectile = true
			else:
				new_note.send_note_projectile = false
			new_note.note_played.connect(change_ready_status)
			new_note.song_over.connect(change_song)
			new_note.player_hit.connect(damage_taken)
			self.progress_ratio = randf()
			new_note.position = self.position
			new_note.rotation = self.rotation + PI / 2
			new_note.speed = 10_000
			var new_music_array : Array = [Stage.get_current_melody(), 
			[0 + cur_count, 1 + cur_count]]
			new_note.music = new_music_array
			$"../AllNotes".add_child(new_note)
			cur_count+=1
			new_note_ready = false

func spawn_note_projectile() -> void:
	pass

func change_ready_status() -> void:
	new_note_ready = true
	note_played.emit()
	
func change_song() -> void:
	if(Stage.next_audio_no() == false):
		printerr("no more audio availiable")
		song_over.emit()
	else:
		print("changed successfully")
		next_section_availiable.emit()
		cur_count = 0

func damage_taken() -> void:
	health_reduced.emit()
