extends Node2D

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		#$Path2D/Spawnpoint.spawn_note_projectile()
		$WavePath2D/WaveSpawnpoint.spawn_wave()
