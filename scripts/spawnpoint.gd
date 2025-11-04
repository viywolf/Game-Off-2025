extends PathFollow2D

@onready var note_projectile_scene : PackedScene = preload("res://scenes/note_projectile.tscn")
var new_note : Node

func spawn_note_projectile() -> void:
	new_note = note_projectile_scene.instantiate()
	# yeah change this to not be random x.x
	self.progress_ratio = randf()
	new_note.position = self.position
	new_note.rotation = self.rotation + PI / 2
	new_note.speed = 10_000
	$"../AllNotes".add_child(new_note)
