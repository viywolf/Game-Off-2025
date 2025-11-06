extends Line2D

@export var curveness : Vector2 = Vector2(-50,-50)
@export var point_pos_array : Array[Vector2] = [
	Vector2(100,200),
	Vector2(200,100),
	Vector2(300,200),
	Vector2(400, 100),
	Vector2(500, 200),
	Vector2(600, 100),
]

@onready var new_curve = Curve2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_wave()

func _process(delta: float) -> void:
	draw_wave()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("right")):
		draw_wave()
		

func draw_wave() -> void:
	points.clear()
	clear_points()
	new_curve.clear_points()
	for point in point_pos_array:
		new_curve.add_point(point, curveness)
	var curved_points = new_curve.get_baked_points()
	for point in curved_points:
		add_point(point)
