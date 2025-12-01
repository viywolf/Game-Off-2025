extends CharacterBody2D

@export var speed : float = 50_000
@export var music : Array = [1, [0,1]] # song, start note, end note
@export var bpm : float = 300

@onready var one_note_length : float = 60/bpm
@onready var notes_to_play : float = music[1][1] - music[1][0]
@onready var start_position : float = one_note_length * music[1][0]
@onready var song_length : float
@onready var buffer_note_length : float = 0.005

@export var send_note_projectile : bool = 1

var fade_out : bool = false
var damage_done : bool = false

const ALL_COLOURS : Array[Color] = [
	Color(0.887, 0.449, 0.215, 1.0),
	Color(0.891, 0.687, 0.178, 1.0),
	Color(0.596, 0.794, 0.376, 1.0),
	Color(0.149, 0.448, 0.761, 1.0),
	Color(0.606, 0.235, 0.776, 1.0),
	Color(1.0, 0.235, 0.571, 1.0),
]

signal note_played
signal song_over
signal player_hit

func _ready() -> void:
	self.modulate = ALL_COLOURS.pick_random()
	bpm = Stage.all_bpms[Stage.cur_level]
	$AudioStreamPlayer2D.stream = Stage.get_current_melody()
	song_length = $AudioStreamPlayer2D.stream.get_length()
	#print("song length: " + str(song_length))
	$AudioStreamPlayer2D.play(start_position)
	await get_tree().create_timer((one_note_length * notes_to_play) - buffer_note_length).timeout
	#$AudioStreamPlayer2D.queue_free()
	fade_out = true
	
	note_played.emit()
	if(music[1][1] * one_note_length >= song_length):
		song_over.emit()
		
	if(send_note_projectile == true):
		$Sprite2D.visible = true
	else:
		$Area2D.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(fade_out == true and get_node_or_null("AudioStreamPlayer2D") != null):
		$AudioStreamPlayer2D.volume_db -= 20 * delta
		if($AudioStreamPlayer2D.volume_db < -10):
			$AudioStreamPlayer2D.queue_free()
	#if(get_node_or_null("AudioStreamPlayer2D")): 
#		if ($AudioStreamPlayer2D.get_playback_position() >= bpm / notes_to_play + start_position):#
#			$AudioStreamPlayer2D.queue_free()
	

func _physics_process(delta: float) -> void:
	velocity = self.transform.x * speed * delta
	move_and_slide()
	# out of the game window
	if(global_position.x > 2000 or global_position.x < -2000
	or global_position.y > 2000 or global_position.y < -2000):
		queue_free()
	if(get_node_or_null("Area2D") and $Area2D.overlaps_area(get_node("/root/Main/Window/Player/Area2D")) 
	and damage_done == false):
		player_hit.emit()
		damage_done = true
