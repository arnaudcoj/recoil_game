
extends RigidBody2D

var player

export var duration = 1
export var canon_cooldown = 0.5
export var ship_recoil_multiplier = 5
export var bullet_impulse_multiplier = 10

onready var duration_timer = get_node("duration_timer")
onready var animations = get_node("animations")

func _ready():
	duration_timer.set_wait_time(duration)
	set_fixed_process(true)
	
func _fixed_process(delta):
	update_rotation()
	
func shoot():
	get_node("animations").play("shot")
	
func update_rotation():
	var velocity = get_linear_velocity()
	set_rot(atan2(velocity.x, velocity.y) - PI/2)

func _on_duration_timer_timeout():
	queue_free()
