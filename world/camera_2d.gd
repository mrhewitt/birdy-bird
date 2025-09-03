extends Camera2D

@export var player: Player

var center_offset: float

func setup( _center_offset: float ) -> void:
	global_position.y = get_viewport_rect().size.y / 2
	center_offset = _center_offset


func _physics_process(_delta: float) -> void:
	global_position.x = player.global_position.x + center_offset


func shake() -> void:
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, 'zoom', Vector2(1.1,1.1), 0.2)
	tween.tween_property(self, 'zoom', Vector2(0.95,0.95), 0.2)
	tween.tween_property(self, 'zoom', Vector2.ONE, 0.2)
