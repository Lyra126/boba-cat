extends Area2D

@export var dialogue_key = "";

var area_active: bool = false

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		SignalBus.emit_signal("display_dialogue", dialogue_key)
		print(dialogue_key)


func _on_mouse_entered() -> void:
	area_active = true


func _on_mouse_exited() -> void:
	area_active = false
