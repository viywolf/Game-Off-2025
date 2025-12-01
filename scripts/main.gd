extends Node2D

@onready var main_menu_scene : PackedScene = preload("res://scenes/main_menu.tscn")
@onready var main_game_scene : PackedScene = preload("res://scenes/window.tscn")
@onready var cutscene_scene : PackedScene = preload("res://scenes/cutscene.tscn")

var new_menu : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	go_to_main__menu()
	new_menu.start_game.connect(start_game)

func start_game() -> void:
	var new_window : Node = main_game_scene.instantiate()
	new_window.go_to_cutscene.connect(add_cutscene)
	add_child(new_window)
	if(get_node_or_null("MainMenu") != null):
		get_node("MainMenu").queue_free()
	
func go_to_main__menu() -> void:
	new_menu = main_menu_scene.instantiate()
	add_child(new_menu)

func add_cutscene() -> void:
	var new_cutscene : Node = cutscene_scene.instantiate()
	new_cutscene.current_scene = Stage.cur_cutscene_no
	new_cutscene.cutscene_over.connect(start_game)
	Stage.cur_cutscene_no += 1
	add_child(new_cutscene)
