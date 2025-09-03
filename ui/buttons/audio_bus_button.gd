extends ToggleScreenButton

@export var audio_bus_name: String


func _on_pressed() -> void:
	super._on_pressed()
	var audio_bus_idx: int = AudioServer.get_bus_index(audio_bus_name)
	AudioServer.set_bus_mute(audio_bus_idx, !is_on)
