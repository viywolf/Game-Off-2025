extends Line2D

@export var point_pos_multiplier__x : int = 100
@export var point_pos_multiplier__y : int = 100
@export var number_of_points : int = 5
@export var curveness_array : Array[Vector2] =[
	Vector2(-50,50), Vector2(-50,-50)
]

@onready var new_curve = Curve2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_wave()

func _process(delta: float) -> void:
	draw_wave()

func draw_wave() -> void:
	points.clear()
	clear_points()
	new_curve.clear_points()
	for i in range(number_of_points):
		var point_to_be_added : Vector2 = Vector2(
			point_pos_multiplier__x * i + point_pos_multiplier__x, 
			point_pos_multiplier__y * ((i+1) % 2) )
		print(point_to_be_added)
		new_curve.add_point(point_to_be_added, curveness_array[i%2])
	var curved_points = new_curve.get_baked_points()
	for point in curved_points:
		add_point(point)
