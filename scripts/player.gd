extends CharacterBody2D

@export var speed :float = 14_000

func _physics_process(delta):
	velocity = Input.get_vector("left","right","up","down") * speed * delta
	move_and_slide()
