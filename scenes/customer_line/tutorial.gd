extends Node2D
var amplitude = 0.1  # Adjust this value to control the amplitude of the bobbing
var frequency = 2  # Adjust this value to control the frequency of the bobbing
var time_passed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.shownCustomerTutorial:
		$".".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	var displacement = amplitude * sin(time_passed * frequency)
	position.y += displacement


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			$".".hide()
			global.shownCustomerTutorial = true
