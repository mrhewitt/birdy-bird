extends Control

const WORLD = preload("res://world/world.tscn")

@export var current_bird: int = 1

@onready var title_screen: TitleScreen = $TitleScreen
@onready var bird_select_screen: BirdSelectScreen = $BirdSelectScreen
@onready var score_screen: ScoreScreen = $ScoreScreen

var best_score: int = 0


func _on_title_screen_start_game() -> void:
	start_game(current_bird)


func _on_title_screen_pick_bird() -> void:
	title_screen.visible = false
	bird_select_screen.visible = true


func _on_bird_select_screen_select_bird(bird_idx: int) -> void:
	current_bird = bird_idx 
	start_game(current_bird)


func show_title_screen() -> void:
	title_screen.best_score = best_score 
	title_screen.visible = true
	

func start_game(bird_idx: int) -> void:
	title_screen.visible = false
	bird_select_screen.visible = false
	var world = WORLD.instantiate()
	world.game_over.connect( show_score_screen )
	world.current_bird = bird_idx
	add_child(world)
	

func show_score_screen( score: int ) -> void:
	score_screen.visible = true	
	score_screen.show_score( score, best_score )
	best_score = max(score,best_score)


func _on_score_screen_back_to_menu() -> void:
	score_screen.visible = false	
	show_title_screen()
