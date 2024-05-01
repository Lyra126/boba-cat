extends Node2D

var ready4Fridge 
var ready4Fridge1
var amplitude = 0.3  # Adjust this value to control the amplitude of the bobbing
var frequency = 2  # Adjust this value to control the frequency of the bobbing
var time_passed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()
	if not global.shownLiquidsTutorial:
		ready4Fridge = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if liquid_station_global.fridge_open:
		if ready4Fridge:
			$".".show()
			ready4Fridge = false

	time_passed += delta
	var displacement = amplitude * sin(time_passed * frequency)
	position.y += displacement

func _input(event):
	if event is InputEventMouseButton and (event.button_index == MOUSE_BUTTON_LEFT or  event.button_index == MOUSE_BUTTON_RIGHT):
		if event.pressed:
			$".".hide()
			$"../tutorial".hide()
			global.shownLiquidsTutorial = true

func _on_help_button_pressed() -> void:
	ready4Fridge = true
