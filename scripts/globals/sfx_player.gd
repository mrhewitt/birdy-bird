extends Node

const SFX = {
	score_point = [
		preload("res://assets/audio/Positive_Button_Collect_-035.wav"),
		preload("res://assets/audio/Positive_Button_Collect_-040.wav")
	],
	dead = [
		preload("res://assets/audio/Losing_Jingle-019.wav")
	],
	click = [
		preload("res://assets/audio/Mouse_Click-008.wav")
	],
	start = [
		preload("res://assets/audio/Positive_Button_Collect_-002.wav")
	]
}

func play_random( group: String ) -> void:
	var sfx_list: Array = SFX.get(group)
	if sfx_list and sfx_list.size() > 0:
		play( sfx_list.pick_random() )


func play(sound_to_play: AudioStream) -> void:
	# create a new audio player and put it in the scene
	# if you forgot to add_child() to incklude it in a scene
	# your sound will not play 
	var stream = AudioStreamPlayer.new()
	get_tree().get_current_scene().add_child(stream)
	# tell it to start playing the sound we chose
	stream.bus = "SFX"
	stream.stream = sound_to_play
	stream.play() 
	# wait for "finished" signal so we can know when it is done
	await stream.finished
	# delete sound player from scene so finished players dont simply continue to pile up
	stream.queue_free()
