
extends Node2D

onready var position = get_node("position")
onready var cooldown = get_node("cooldown")
onready var shot_particles = get_node("shot_particles")

var operational = true

func _ready():
	pass
	
func can_fire():
	return operational
	
func fire(i_bullet, player):
		var impulse = position.get_global_pos() - get_global_pos()

		i_bullet.player = player
		i_bullet.set_global_pos(position.get_global_pos())
		
		i_bullet.apply_impulse(Vector2(0,0), impulse * i_bullet.bullet_impulse_multiplier)
		get_parent().get_parent().apply_impulse(Vector2(0,0), -impulse * i_bullet.ship_recoil_multiplier)

		i_bullet.shoot()
		controler.get_level().add_bullet(i_bullet)
		shot_particles.set_emitting(true)
		
		
		operational = false
		cooldown.set_wait_time(i_bullet.canon_cooldown)
		cooldown.start()

func _on_cooldown_timeout():
	operational = true
