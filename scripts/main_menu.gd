extends Node2D

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _on_start_button_pressed() -> void:
	start_game.emit()
