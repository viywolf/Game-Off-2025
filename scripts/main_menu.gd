extends Node2D

signal start_game

func _on_start_button_pressed() -> void:
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.5).timeout
	start_game.emit()
