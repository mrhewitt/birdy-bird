extends Button
class_name ScreenButton

func _on_pressed() -> void:
	SfxPlayer.play_random('click')
