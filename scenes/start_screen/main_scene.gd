extends Control

func _ready():
	pass

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen/credits.tscn")

func _on_play_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen/loading_scene.tscn")
