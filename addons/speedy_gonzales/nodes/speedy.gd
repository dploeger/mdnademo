# Speedy mouse cursor handling
extends CanvasLayer


# A dictionary of mouse cursor hotspots for cursor shapes
var hotspots: Dictionary

# A dictionary of mouse cursor textures for cursor shapes
var textures: Dictionary

# The current mouse cursors hotspot
var current_hotspot: Vector2

# The current shape
var current_shape

# Wether the mouse cursor is hidden currently
var hidden: bool setget _set_hidden

# Keep the current cursor shape and don't update it
var keep_shape: bool = false


# Activate mouse cursor handling by Speedy and load default cursors
func _init():
	if not Engine.editor_hint:
		Input.set_mouse_mode(
			Input.MOUSE_MODE_HIDDEN
		)
	set_custom_mouse_cursor(
		preload("res://addons/speedy_gonzales/images/arrow.tres")
	)


# Handle mouse motions and switch cursor when needed
func _input(event):
	if event is InputEventMouseMotion:
		$Cursor.position = event.position - current_hotspot
		if not hidden and not keep_shape \
				and current_shape != Input.get_current_cursor_shape():
			_update_shape()
		

# Set the custom mouse cursor
func set_custom_mouse_cursor(
	image: SpriteFrames, 
	shape = Input.CURSOR_ARROW, 
	hotspot: Vector2 = Vector2(0,0),
	target_position = null
):
	textures[shape] = image
	hotspots[shape] = hotspot
	if target_position == null and get_viewport() != null:
		target_position = get_viewport().get_mouse_position() - current_hotspot
	elif target_position != null:
		get_viewport().warp_mouse(target_position + hotspot)
	if shape == current_shape:
		current_hotspot = hotspots[shape]
		$Cursor.frames = textures[shape]
		$Cursor.position = target_position


# Disable the mouse cursor
func _set_hidden(value: bool):
	hidden = value
	if hidden:
		$Cursor.hide()
	else:
		$Cursor.show()
		_update_shape()


# Update the cursor to reflect the current shape
func _update_shape():
	var shape = Input.get_current_cursor_shape()
	current_shape = shape
	current_hotspot = hotspots[shape]
	$Cursor.frames = textures[shape]
