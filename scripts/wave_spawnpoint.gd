extends PathFollow2D
@onready var wave_scene : PackedScene = preload("res://scenes/wave.tscn")
var new_wave : Node

signal health_reduced

func spawn_wave() -> void:
	new_wave = wave_scene.instantiate()
	self.progress_ratio = randf()
	new_wave.position = self.position
	new_wave.player_hit.connect(damage_taken)
	new_wave.get_child(0).rotation = self.rotation + PI / 2
	$"../AllWaves".add_child(new_wave)

func damage_taken() -> void:
	health_reduced.emit()
	await get_tree().create_timer(0.005).timeout
