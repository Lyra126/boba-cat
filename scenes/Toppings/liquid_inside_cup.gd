extends Node2D

@onready var sprite = $Polygon2D/liquid_sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.get_liquid_inside_cup(sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


