extends Node2D

@onready var sprite = $Polygon2D/liquid_sprite
@onready var t5 = $"Polygon2D/toppings-5"
@onready var t4 = $"Polygon2D/toppings-4"
@onready var t3 = $"Polygon2D/toppings-3"
@onready var t2 = $"Polygon2D/toppings-2"
@onready var t1 = $"Polygon2D/toppings-1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.modulate.a = 0.8
	global.get_liquid_inside_cup(sprite)
	global.get_toppings_inside_cup(t1, t2, t3, t4, t5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


