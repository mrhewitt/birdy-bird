extends Camera2D

@export var player: Player

var center_offset: float

func setup( _center_offset: float ) -> void:
	global_position.y = get_viewport_rect().size.y / 2
	center_offset = _center_offset


func _physics_process(_delta: float) -> void:
	global_position.x = player.global_position.x + center_offset
