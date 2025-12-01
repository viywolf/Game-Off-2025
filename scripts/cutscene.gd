extends Node2D

@export var current_scene : int
var current_dialouge_no : int = 0

const before_1 : Array[Array] = [
	["Before1Player", "Placeholder"], ["Before1Boss", "Placeholder2"]
]

const after_1 : Array[Array] = [
	["After1Player", "Placeholder"], ["After1Boss", "Placeholder"],
]

const after_2 : Array[Array] = [
	["After2Player", "Placeholder"], ["After2Boss", "Placeholder"],
]

const epilouge : Array[Array] = [
	["EpilougeBoss", "Placeholder"],
]

const ALL_SCENES : Array[Array] = [
	[], before_1, after_1, after_2, epilouge
]

signal cutscene_over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_text(ALL_SCENES[current_scene][current_dialouge_no][1])
	$CurrentFrame.animation = ALL_SCENES[current_scene][current_dialouge_no][0]
	$CurrentFrame.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("enter")):
		next_slide()
		
func next_slide() -> void:
	if(current_dialouge_no + 1 >= ALL_SCENES[current_scene][current_dialouge_no].size()):
		cutscene_over.emit()
	else:
		current_dialouge_no += 1
		change_text(ALL_SCENES[current_scene][current_dialouge_no][1])
		$CurrentFrame.animation = ALL_SCENES[current_scene][current_dialouge_no][0]
		$CurrentFrame.play()

func change_text(text : String) -> void:
	$CurrentFrame/Label.text = text
