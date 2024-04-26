extends Node2D

@onready var cup_spot = $"../cup_spot"


var selected
var offset = Vector2.ZERO


var target_position


func _ready():
	global.SomethingBeingClickedRn = false;
	
func _process(delta):
	pass
