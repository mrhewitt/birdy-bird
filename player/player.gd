extends CharacterBody2D
class_name Player

signal start_game
signal player_died

const TOP_MARGIN:float = 25
const GRAVITY:float = 8.0
const MAX_FALL_VELOCITY:float = 600.0
const JUMP_VELOCITY = -400
const ACCELEROMETER_SPEED: float = 130.0

@export var speed: float = 400
@export var current_bird: int = 1:
	set(bird_idx):
		current_bird = bird_idx
		animated_sprite_2d.current_bird = current_bird

@onready var animated_sprite_2d: BirdAnimationSprite = $BirdAnimationSprite

var use_accelerometer: bool = false
var started: bool = false
var dead: bool = false


func _ready() -> void:
	use_accelerometer = OS.get_name() in ["Android", "iOS"]
	animated_sprite_2d.current_bird = current_bird


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly_action"):
		if started:
			velocity.y += JUMP_VELOCITY
		else:
			started = true
			start_game.emit()
			

func _physics_process(_delta: float) -> void:
	if !dead:
		if started:
			velocity.y = minf(GRAVITY + velocity.y, MAX_FALL_VELOCITY)
			if velocity.y > 0:
				animated_sprite_2d.pause()
			else:
				animated_sprite_2d.play()
				
		rotation = velocity.angle()
		velocity.x = speed 
		move_and_slide()
		
		if global_position.y < TOP_MARGIN:
			global_position.y = 0


func die() -> void:
	dead = true
	SfxPlayer.play_random("dead")
	animated_sprite_2d.play('death')
	await animated_sprite_2d.animation_finished
	visible = false
	await get_tree().create_timer(0.5).timeout
	player_died.emit()
	
