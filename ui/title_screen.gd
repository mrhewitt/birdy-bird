extends Control
class_name TitleScreen

signal start_game
signal pick_bird

@export var best_score: int = 0:
	set(score):
		best_score = score
		if score_label:
			score_label.text = str(best_score)

@onready var score_label: Label = $ScoreLabel

	
func _on_play_button_pressed() -> void:
	SfxPlayer.play_random('click')
	start_game.emit()


func _on_pick_bird_button_pressed() -> void:
	SfxPlayer.play_random('click')
	pick_bird.emit()
