extends Node2D

var OrderForm
@onready var progress_bar : TextureProgressBar = $TextureProgressBar
@onready var canfire = true
@onready var timer = $Timer
@onready var percentage_of_time

# Called when the node enters the scene tree for the first time.
func _ready():
	$Next.pressed.connect(self._on_next_pressed)
	OrderForm = preload("res://scenes/OrderForm/OrderForm.tscn").instantiate()
	add_child(OrderForm)
	showOrder()
	if canfire:
		canfire = false
		$Timer.start()

func showOrder():
	OrderForm.show()
	
func hideOrder():
	OrderForm.hide()


func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/drink_station/liquid_station.tscn")

	
	
func _process(delta):
	if timer.get_time_left() > 0:
		percentage_of_time = ((1 - timer.get_time_left() / timer.get_wait_time()) * 100)
		progress_bar.value = percentage_of_time
	else:
		progress_bar.value = 100

   


func _on_timer_timeout():
	canfire = true
	timer.stop()
