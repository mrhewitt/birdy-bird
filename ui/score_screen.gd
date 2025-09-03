extends Control
class_name ScoreScreen

signal back_to_menu


@onready var trophy: TextureRect = %Trophy
@onready var crowns: Array[CrownSprite] = [%CrownSprite1,%CrownSprite2,%CrownSprite3]
@onready var current_score_label: Label = %CurrentScoreLabel
@onready var best_score_label: Label = %BestScoreLabel


func show_score( current_score: int, best_score: int ) -> void:
	if current_score > best_score:
		trophy.modulate = Color.WHITE
	else:
		trophy.modulate = Color(0.35,0.35,0.35,0.75)
		
	# only get crown if u pass the difficult level, so no crowns until points, etc
	if current_score >= 10:
		for i in range(0,mini(3,current_score/10)):
			crowns[i].score = current_score 

	current_score_label.text = "Your Score: " + str(current_score)	
	best_score_label.text = "Best Score: " + str(best_score)


func _on_back_button_pressed() -> void:
	back_to_menu.emit()
