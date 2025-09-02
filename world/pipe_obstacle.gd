extends Node2D
class_name PipeObstacle

signal obstacle_passed

## upper pipe will never be shorter than this percent of screen height
@export var pipe_margin_upper_percent: float = 0.2

## lower pipe will never be shorter than this percent of screen height
@export var pipe_margin_lower_percent: float = 0.2

## what percentage of screen height pipe gap is at
@export var pipe_gap_percent: Array[float] = [0.3, 0.25, 0.2] 

@onready var upper_obstacle: NinePatchRect = $UpperObstacle
@onready var lower_obstacle: NinePatchRect = $LowerObstacle
@onready var upper_collision_shape: CollisionShape2D = $UpperObstacle/Area2D/UpperCollisionShape
@onready var lower_collision_shape: CollisionShape2D = $LowerObstacle/Area2D/LowerCollisionShape

@onready var viewport_size: Vector2 = get_viewport_rect().size
@onready var pipe_width: float = upper_obstacle.size.x


func init( screen_center: float, _difficulty: int ) -> void:
	# pick a  gap size based on difficult index (0/1/2), use min to ensure if difficult passed
	# is greated than entries in gap array we use hightest difficulty instead of crashing
	var gap_percent: float = pipe_gap_percent[ mini(_difficulty, pipe_gap_percent.size()) ]
	create_new_obstacle( screen_center + viewport_size.x/2, gap_percent )


func create_new_obstacle( start_position_x: float, gap_percent: float ) -> void:
	
	# larget upper pipe can be is lower margin_percent plus pipe gap, 
	# we include lower margin as upper pipe cannot be so big lower pipe cannot meet its minimum	
	var upper_pipe_max_percent: float = 1 - (gap_percent + pipe_margin_lower_percent)
	var top_height: float = randf_range(viewport_size.y * pipe_margin_upper_percent, viewport_size.y * upper_pipe_max_percent)
	var pipe_gap: float = get_viewport_rect().size.y * gap_percent
	
	upper_obstacle.size.y = top_height
	lower_obstacle.size.y = viewport_size.y - pipe_gap - top_height
	
	global_position.x = start_position_x + pipe_width
	lower_obstacle.global_position.y = viewport_size.y
	set_collision_shape(upper_collision_shape, upper_obstacle.size.y)
	set_collision_shape(lower_collision_shape, lower_obstacle.size.y)


func set_collision_shape(collision_shape: CollisionShape2D, height: float) -> void:
	var shape := RectangleShape2D.new()
	shape.size.y = height * 0.95		# be slightly forgiving on very end of pipes  
	shape.size.x = pipe_width
	
	collision_shape.position.y = height / 2
	collision_shape.position.x = pipe_width / 2
	collision_shape.shape = shape
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	obstacle_passed.emit()
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.die()
