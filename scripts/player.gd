extends CharacterBody2D

@export var speed :float = 14_000
var idle : bool = true
var facing : String = "down"

@export var can_move : bool = 1

func _physics_process(delta):
	#velocity = Input.get_vector("left","right","up","down") * speed * delta
	if(can_move == false):
		$AnimatedSprite2D.stop()
	else:
		if(Input.is_action_pressed("down") or Input.is_action_pressed("up")
			or Input.is_action_pressed("left") or Input.is_action_pressed("right")):
			idle = false
			if Input.is_action_pressed("left"):
				velocity = Vector2(-1 * speed * delta,0)
				facing = "side"
				$AnimatedSprite2D.flip_h = false
			elif Input.is_action_pressed("right"):
				velocity = Vector2(1 * speed * delta,0)
				facing = "side"
				$AnimatedSprite2D.flip_h = true
			if Input.is_action_pressed("up"):
				velocity = Vector2(0,-1 * speed * delta)
				facing = "up"
			elif Input.is_action_pressed("down"):
				velocity = Vector2(0,1 * speed * delta)
				facing = "down"
		else:
			velocity = Vector2.ZERO
			idle = true
		manage_animations()
		move_and_slide()

func manage_animations() -> void:
	if(idle):
		if (facing == "side"):
			$AnimatedSprite2D.play("idle_side")
		if (facing == "up"):
			$AnimatedSprite2D.play("idle_up")
		if (facing == "down"):
			$AnimatedSprite2D.play("idle_down")
	else:
		if (facing == "side"):
			$AnimatedSprite2D.play("run_side")
		if (facing == "up"):
			$AnimatedSprite2D.play("run_up")
		if (facing == "down"):
			$AnimatedSprite2D.play("run_down")
