extends CharacterBody2D

@export var speed :float = 14_000

func _physics_process(delta):
	velocity = Input.get_vector("left","right","up","down") * speed * delta
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area)
