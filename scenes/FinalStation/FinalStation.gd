extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_submit_order_pressed():
	var ordersMatch = false
	print("checking if player made order correctly...")
	if len(global.order) == len(global.playerOrder):
		for i in range(len(global.order)):
			if global.order[i] != global.playerOrder[i]:
				return
		ordersMatch = true
	else:
		print("Arrays have different lengths, cannot compare elements.")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/Toppings/Toppings.tscn")
