# A layer that is supposed to grab right mouse button clicks
# to show the menu
extends CanvasLayer


# Set the top margin to under the inventory bar
func set_top(top: float):
	$Control.margin_top = top


# React to mouse button events on the control
func _input(event):
	if MdnaInventory.selected_item == null and \
			event is InputEventMouseButton and \
			(event as InputEventMouseButton).button_index == BUTTON_RIGHT and \
			not (event as InputEventMouseButton).pressed:
		if get_viewport().get_mouse_position().y >= $Control.margin_top:
			get_tree().set_input_as_handled()
			MainMenu.toggle()
