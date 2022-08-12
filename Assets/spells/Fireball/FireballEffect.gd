extends AnimatedSprite

const cast_sound = preload("res://Assets/spells/Fireball/cast.wav")
const impact_sound = preload("res://Assets/spells/Fireball/explosion.wav")

func cast():
	play("Flying")
	EffectPlayer.play_sfx(cast_sound)

func explode():
	EffectPlayer.play_sfx(impact_sound)
	play("Impact")
	connect("animation_finished", self, "queue_free")
