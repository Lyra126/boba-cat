extends Sprite2D

var amplitude = 0.3  # Adjust this value to control the amplitude of the bobbing
var frequency = 2  # Adjust this value to control the frequency of the bobbing
var time_passed = 0

var original_texture : Texture
var target_texture : Texture

var transition_time = 1.0
var transition_timer = 0.0
var transition_in_progress = false

# Shader parameters
var transition_progress = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	original_texture = texture
	target_texture = preload("res://assets/grabArms.png")

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			texture = target_texture
		else:
			texture = original_texture
		
	
func _process(delta):
	time_passed += delta
	var displacement = amplitude * sin(time_passed * frequency)
	position.y += displacement


