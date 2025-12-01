extends TextureButton

@export var text : String = "Start"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = text

func _on_mouse_entered() -> void:
	$Label.position.x += 1
	$Label.position.y += 1


func _on_mouse_exited() -> void:
	$Label.position.x -= 1
	$Label.position.y -= 1
