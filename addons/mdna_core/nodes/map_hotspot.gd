# A hotspot supporting precaching of scenes and showing a loading
# screen and playing a tune while doing so
tool
class_name MapHotspot, "res://addons/mdna_core/images/map_hotspot.svg"
extends Hotspot


# The loading image to show while the scenes for the new location are
# cached
export(Texture) var loading_image


# The music that should be played while loading
export(AudioStream) var location_music


# Update cache blocking for the target scene, then jump there
func _gui_input(event):
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == BUTTON_LEFT and \
				 MdnaInventory.selected_item == null and target_scene != "":
			accept_event()
			Boombox.play_music(location_music)
			MdnaCore.target_view = target_view
			WaitingScreen.set_image(loading_image)
			MdnaCore.update_cache(target_scene, true)
			yield(MdnaCore, "queue_complete")
			MdnaCore.change_scene(target_scene)
		elif (event as InputEventMouseButton).button_index == BUTTON_RIGHT:
			MainMenu.toggle()
