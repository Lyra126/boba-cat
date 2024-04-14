extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_submit_order_pressed():
	print("submitted")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/Toppings/Toppings.tscn")
