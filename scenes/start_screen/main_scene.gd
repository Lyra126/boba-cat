extends Control

func _ready():
	$Play.pressed.connect(self._on_play_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/start_screen/loading_scene.tscn")
