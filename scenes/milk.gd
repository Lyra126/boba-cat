#extends TextureRect
#
#var selected = false;
#var mousePos = null;
#
#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and selected == false:
		#selected = true;
		#
#func _process(delta):
	#if selected == true:
		#mousePos = get_global_mouse_position();
		#position = mousePos;

extends Sprite2D

func _get_drag_data(at_position):
	var preview_texture = Sprite2D.new()
	preview_texture.texture = texture
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview (preview)
	texture = null
	return preview_texture.texture 
	
func _can_drop_data(_pos, data):
	return data is Texture2D
	
func _drop_data(_pos, data):
	texture = data
