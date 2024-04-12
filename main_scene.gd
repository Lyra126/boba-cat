extends Control

func _ready():
	$Play.pressed.connect(self._on_play_pressed)
	$Quit.pressed.connect(self._on_quit_pressed)

func _on_play_pressed():
	print("play is pressed")
	get_tree().change_scene_to_file("res://loading_scene.tscn")

func _on_quit_pressed():
	print("quit is pressed")
	get_tree().quit()
