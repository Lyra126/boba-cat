extends Node2D

var cup_in_attach_lid = false

# Called when the node enters the scene tree for the first time.
func _ready():
	global.hasCup = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_submit_order_pressed():
	get_tree().change_scene_to_file("res://scenes/Rate/rate.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/drink_station/liquid_station.tscn")



func _on_attach_lid_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
