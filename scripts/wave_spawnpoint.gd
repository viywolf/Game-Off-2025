extends PathFollow2D
@onready var wave_scene : PackedScene = preload("res://scenes/wave.tscn")
var new_wave : Node

func spawn_wave() -> void:
	new_wave = wave_scene.instantiate()
	self.progress_ratio = randf()
	new_wave.position = self.position
	#new_wave.rotation = self.rotation + PI / 2
	new_wave.get_child(0).rotation = self.rotation + PI / 2
	$"../AllWaves".add_child(new_wave)
