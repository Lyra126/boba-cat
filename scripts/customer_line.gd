extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Next.pressed.connect(self._on_next_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/make_boba.tscn")