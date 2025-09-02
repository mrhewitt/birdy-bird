extends AnimatedSprite2D
class_name BirdAnimationSprite

@export var current_bird: int = 1:
	set(bird_idx):		
		var num_birds = sprite_frames.get_animation_names().size() - 1
		current_bird = bird_idx
		if current_bird < 1:
			current_bird = num_birds
		if current_bird > num_birds:
			current_bird = 1
		if !sprite_frames.has_animation(get_animation_name(current_bird)):
			current_bird = 1
		play( get_animation_name(current_bird) )
	
	
func next_bird() -> int:
	current_bird += 1
	return current_bird
	
	
func prev_bird() -> int:
	current_bird -= 1
	return current_bird

	
func get_animation_name(bird_idx: int) -> String:
	return "bird_0" + str(bird_idx) 
