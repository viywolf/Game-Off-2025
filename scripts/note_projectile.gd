extends CharacterBody2D

@export var speed : float = 10_000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = self.transform.x * speed * delta
	move_and_slide()
	# out of the game window
	if(global_position.x > 800 or global_position.x < -100
	or global_position.y > 800 or global_position.y < -100):
		queue_free()
