extends CharacterBody2D

@export var point_pos_multiplier__x : int = 100
@export var point_pos_multiplier__y : int = 100
@export var number_of_points : int = 25
@export var curveness_array : Array[Vector2] =[
	Vector2(-50,50), Vector2(-50,-50)
]
@export var speed : float = 0
@export var delete_self : bool = false
@export var percentage_start : float = 0.0
@export var percentage_shown : float = 1.0
@export var curve_progress_speed : float = 0.0

@onready var new_curve = Curve2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Wave.rotation_degrees += 180
	$Wave.position.x -= (point_pos_multiplier__x * number_of_points)/2
	$Area2D.transform = $Wave.transform
	draw_wave()

func _process(delta: float) -> void:
	percentage_start += curve_progress_speed * delta
	percentage_shown += curve_progress_speed * delta
	draw_wave()
	velocity = self.transform.x * speed * delta
	move_and_slide()
	if(percentage_start == 1): delete_self = true
	if(delete_self == true):
		queue_free()

func draw_wave() -> void:
	$Wave.points.clear()
	$Wave.clear_points()
	new_curve.clear_points()
	for i in range(number_of_points):
		var point_to_be_added : Vector2 = Vector2(
			point_pos_multiplier__x * i + point_pos_multiplier__x, 
			point_pos_multiplier__y * ((i+1) % 2) )
		new_curve.add_point(point_to_be_added, curveness_array[i%2])
	var curved_points : Array = new_curve.tessellate()
	for i : float in range(curved_points.size()):
		var cur_point_percentage : float = i / curved_points.size()
		if(cur_point_percentage > percentage_start and cur_point_percentage < percentage_shown):
			$Wave.add_point(curved_points[i])
		else: pass
	# Make collision shape
	var temp_points_array : PackedVector2Array = $Wave.points.duplicate()
	var temp_array2 : PackedVector2Array
	# Half the number
	for i in range(temp_points_array.size()):
		if(i%6 == 0):
			temp_array2.append(temp_points_array[i])
	# Reverse it so the points start from the end point of the previous collisions so 
	# collision lines do not cross
	temp_points_array.reverse()
	# Half the number again before adding it to arr2
	for i in range(temp_points_array.size()):
		if(i%6 == 0):
			# Add to the y value of every point to avoid collisions and close the polygon
			temp_array2.append(temp_points_array[i] + Vector2(0,10))
	$Area2D/CollisionPolygon2D.polygon = temp_array2


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(str(area) + " touched from wave")
