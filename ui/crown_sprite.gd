extends Sprite2D
class_name CrownSprite
		
@export var empty_modulation := Color(0.33,0.33,0.33,0.5)

@export var score: int = 0:
	set(score_in):
		score = score_in
		# only show crowns if we have 10 or more points,
		# broze 10 -19
		# silver 20-29
		# gold 30 +
		frame = maxi(0,mini(hframes,(score/10)-1))
		modulate = Color.WHITE if score >= 10 else empty_modulation
