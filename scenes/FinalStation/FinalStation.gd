extends Node2D

var cup_in_attach_lid = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_submit_order_pressed():
	get_tree().change_scene_to_file("res://scenes/Rate/rate.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/drink_station/liquid_station.tscn")


func _on_attach_lid_body_entered(body):
	if body.is_in_group("cup"):
		cup_in_attach_lid = true
		emit_signal("cup_snapped", body.global_position)


func _on_attach_lid_body_exited(body):
	if body.is_in_group("cup"):
		cup_in_attach_lid = false


func _on_attach_lid_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				if cup_in_attach_lid:
					$Cup.position = $AttachLid.global_transform.origin
				else:
					if cup_in_attach_lid:
						$Cup.position = $AttachLid.global_transform.origin
