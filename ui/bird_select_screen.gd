extends Control
class_name BirdSelectScreen

signal select_bird(bird_idx: int)

@export var current_bird: int = 1

@onready var bird_animation_sprite: BirdAnimationSprite = %BirdAnimationSprite


func _ready() -> void:
	bird_animation_sprite.global_position = get_viewport_rect().size/2


func _on_button_left_pressed() -> void:	
	SfxPlayer.play_random('click')
	current_bird = bird_animation_sprite.prev_bird()


func _on_button_right_pressed() -> void:	
	SfxPlayer.play_random('click')
	current_bird = bird_animation_sprite.next_bird()


func _on_play_button_pressed() -> void:	
	SfxPlayer.play_random('click')
	select_bird.emit(current_bird)
