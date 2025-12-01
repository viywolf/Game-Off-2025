extends Node2D

@export var current_scene : int
var current_dialouge_no : int = 0
var is_epilouge : bool = 0

const before_1 : Array[Array] = [
	["After2Player", "Ugh... what just happened?"], 
	["After1Player", "Last thing I remember, I was playing that old arcade game..."], 
	["Before1Player", "Where am I now?"], 
	["Before1Boss", "I see you have come across my land..."], 
	["Before1Boss", "Here to destroy what's mine?"], 
	["Before1Boss", "I will NOT let that happen."], 
	["Before1Player", "What is going on!?"], 
	["Before1Player", "Who is this person? What do they want from me?"],
]

const after_1 : Array[Array] = [
	["After1Boss", "Hm you.. you are more stubborn than I thought."],
	["After1Boss", "...I have been going easy on you this whole time."],
	["After1Boss", "You will not survive now..."],
	["After1Player", "I need to get out of here and figure out a plan."], 
	["After1Player", "But there is no exit or escape."], 
	["After1Player", "I think... I have to win."], 
	["After1Player", "I have to survive."], 
]

const after_2 : Array[Array] = [
	["After2Boss", "You are really starting to get on my nerves."],
	["After2Boss", "I am done playing with you."],
	["After2Boss", "I have not needed to use my full power yet, but now... I will not hold back."],
	["After2Player", "If I keep moving I can probably avoid getting hit."], 
	["After2Player", "It keeps getting harder, but I think I can do it."], 
	["After2Player", "Just one more..."], 
]

const epilouge : Array[Array] = [
	["EpilougeBoss", "*cough*... Impressive."],
	["EpilougeBoss", "But know you will not get away."],
]

const cool_epilouge_text : Array[String] = [
	"...",
	"...",
	"Huh?",
	"Aaah!",
	"",
	"[SYSTEM: Player has won!]",
	"Um... I guess that was one way to end things...",
	"Huh?",
	"Aaah!",
	"",
	"",
	""
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
	$Arrow.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("enter")):
		next_slide()
		
func next_slide() -> void:
	if(current_scene == 4 and current_dialouge_no == 1 and is_epilouge == false):
		is_epilouge = true
		$CurrentFrame.animation = "RestOfTheEpilouge"
		$CurrentFrame.frame = 0
		$CurrentFrame.stop()
		change_text(cool_epilouge_text[$CurrentFrame.frame])
	if(is_epilouge == true):
		if($CurrentFrame.frame == 9):
			$WinScreen.visible = true
		$CurrentFrame.frame += 1
		change_text(cool_epilouge_text[$CurrentFrame.frame])
		return
	if(current_dialouge_no + 1 >= ALL_SCENES[current_scene].size()):
		if(Stage.cur_level == 3):
			pass
		else:
			cutscene_over.emit()
	else:
		current_dialouge_no += 1
		change_text(ALL_SCENES[current_scene][current_dialouge_no][1])
		$CurrentFrame.animation = ALL_SCENES[current_scene][current_dialouge_no][0]
		$CurrentFrame.play()

func change_text(text : String) -> void:
	$CurrentFrame/Label.text = text
