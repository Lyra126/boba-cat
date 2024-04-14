extends Node2D

var OrderForm

# Called when the node enters the scene tree for the first time.
func _ready():
	$Next.pressed.connect(self._on_next_pressed)
	OrderForm = preload("res://scenes/OrderForm/OrderForm.tscn").instantiate()
	add_child(OrderForm)
	showOrder()

func showOrder():
	OrderForm.show()
	
func hideOrder():
	OrderForm.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/drink_station/make_boba.tscn")
