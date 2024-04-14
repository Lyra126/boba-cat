extends Sprite2D

var amplitude = 0.5  # Adjust this value to control the amplitude of the bobbing
var frequency = 2  # Adjust this value to control the frequency of the bobbing
var time_passed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func _process(delta):
	time_passed += delta
	var displacement = amplitude * sin(time_passed * frequency)
	position.y += displacement
