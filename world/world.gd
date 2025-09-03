extends Node2D
class_name World

signal game_over(score)


const PIPE_OBSTACLE = preload("res://world/pipe_obstacle.tscn")

@export var current_bird: int = 1

## What fraction of screen player is indented right-wards from left, 
## so 0.5 is half way, 0.3 is first third etc, 0.25 is first quarter etc
@export var player_margin_offset: float = 0.25

@onready var start_promp_label: Label = $HUD/StartPrompLabel
@onready var player: Player = $Player
@onready var pipe_generator: Timer = $PipeGenerator
@onready var camera_2d: Camera2D = $Camera2D
@onready var score_label: Label = %ScoreLabel
@onready var score_area: Control = %ScoreArea
@onready var background_sprite_2d: Sprite2D = $ParallaxBackground/ParallaxLayer/BackgroundSprite2D
@onready var crowns: Array[CrownSprite] = [%CrownSprite1, %CrownSprite2, %CrownSprite3]
@onready var pause_button: PauseButton = %PauseButton
@onready var pause_area: Control = %PauseArea

@onready var viewport_size := get_viewport_rect().size

# space between left edge of screen and player, used so we can measure where
# current edge of screen is in world co-ords after scrolling
var player_left_margin: float = 0.0
var score: int = 0
var difficulty: int  = 0


func _ready() -> void:
	# pick a random background for the run
	background_sprite_2d.frame = randi_range(0,background_sprite_2d.hframes-1)
	player.current_bird = current_bird
	
	# use margin offset to place player in the scene
	player.global_position.x = viewport_size.x * player_margin_offset
	player.global_position.y = viewport_size.y / 2
	
	# push camera out in front of player, so camera reamins in screen "center"
	player_left_margin = player.global_position.x 
	camera_2d.setup( viewport_size.x/2 - player.global_position.x  )


func _on_player_start_game() -> void:
	SfxPlayer.play('start')
	
	for i in range(0,3):
		crowns[i].score = 0		
	start_promp_label.visible = false
	score_area.visible = true
	pause_button.visible = true
	
	compute_difficulty()
	pipe_generator.start()
	generate_pipe()
	

func _on_pipe_generator_timeout() -> void:
	generate_pipe()
	
	
func score_point() -> void:
	score += 1 
	show_score(score)	
	compute_difficulty()	
	
	SfxPlayer.play_random("score_point")
	if score > 0 and score % 10 == 0 and score <= 30:
		SfxPlayer.play('level_up')
		

func compute_difficulty() -> void:
	difficulty = mini(score/10,2)

		
		
func show_score( _score: int ) -> void:	
	score_label.text = str(_score)
	# only get crown if u pass the difficulty level, so 
	# 1 x bronze at 10-19
	# 2 x silver at 20-29
	# 3 x gold at 30+
	for i in range(0,mini(3,score/10)):
		crowns[i].score = score
		
	
func generate_pipe() -> void:
	var pipe_obstacle = PIPE_OBSTACLE.instantiate()
	pipe_obstacle.connect("obstacle_passed", score_point)
	add_child(pipe_obstacle)
	pipe_obstacle.init( camera_2d.global_position.x, difficulty )


func _on_player_player_died() -> void:
	queue_free()
	game_over.emit(score)


func _on_pause_button_game_paused() -> void:
	pause_button.visible = false
	pause_area.visible = true
	get_tree().paused = true


func _on_play_button_pressed() -> void:
	pause_button.visible = true
	get_tree().paused = false
	pause_area.visible = false


func _on_player_hit_obstacle() -> void:
	camera_2d.shake()


func _on_kill_plane_body_entered(body: Node2D) -> void:
	player.die()
