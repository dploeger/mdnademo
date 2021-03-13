# A hotspot supporting precaching of scenes and showing a loading
# screen and playing a tune while doing so
tool
class_name MapHotspot, "res://addons/egoventure/images/map_hotspot.svg"
extends Hotspot


# The minimum time to wait when switching scenes
const MIN_WAITING_TIME = 4


# The loading image to show while the scenes for the new location are
# cached
export(Texture) var loading_image

# The music that should be played while loading
export(AudioStream) var location_music

# The new location (subdirectory of the scene files)
export(String) var location = ""

# Set the boolean value of this variable in the state to true
export(String) var state_variable = ""


# Connect the pressed signal
func _init():
	hotspot_type = Cursors.Type.MAP


# Update cache blocking for the target scene, then jump there
func _on_pressed():
	release_focus()
	if Inventory.selected_item == null:
		Speedy.hidden = true
		accept_event()
		if state_variable:
			EgoVenture.state.set(state_variable, false)
		Boombox.play_music(location_music)
		EgoVenture.target_view = target_view
		EgoVenture.current_location = location
		WaitingScreen.set_image(loading_image)
		var start = OS.get_ticks_msec()
		var caches = EgoVenture.update_cache(target_scene, true)
		if caches > 0:
			yield(EgoVenture, "queue_complete")
		var end = OS.get_ticks_msec()
		if ((end - start) / 1000) < MIN_WAITING_TIME:
			WaitingScreen.show()
			yield(
				get_tree().create_timer(
					ceil(MIN_WAITING_TIME-((end - start) / 1000))
				),
				"timeout"
			)
			WaitingScreen.hide()
		Speedy.hidden = false
		EgoVenture.change_scene(target_scene)