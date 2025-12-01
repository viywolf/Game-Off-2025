extends HBoxContainer

const BASE_NO_OF_HEARTS = 3

@export var hearts_left : int = BASE_NO_OF_HEARTS

signal player_dead

func reduce_heart() -> void:
	hearts_left -= 1
	if(hearts_left <= 0):
		player_dead.emit()

func update_hearts() -> void:
	for i in range(BASE_NO_OF_HEARTS):
		if(hearts_left >= i + 1):
			get_child(i).disabled = false
		else:
			get_child(i).disabled = true
