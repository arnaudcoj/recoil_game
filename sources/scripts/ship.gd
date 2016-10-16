
extends RigidBody2D

export var player = 1

signal died

var shield_active = true
var life = 3

onready var canons = get_node("canons")

onready var canon_up = canons.get_node("canon_up")
onready var canon_down = canons.get_node("canon_down")
onready var canon_left = canons.get_node("canon_left")
onready var canon_right = canons.get_node("canon_right")

onready var shield = get_node("shield")

onready var cooldown = get_node("cooldown")

onready var bullet_spawner = get_node("bullet_spawner")

onready var skin = get_node("skin")

onready var hit_particles = get_node("hit_particles")

func _ready():
	set_process_input(true)
	get_node("player_name").set_text(str(player))

func change_skin(new_skin):
	skin.queue_free()
	add_child(new_skin)
	skin = new_skin
	skin.set_pos(Vector2(0,0))

func _input(event):
	if event.is_action_pressed("p" + str(player) + "_up"):
		fire_canon(canon_up)
	if event.is_action_pressed("p" + str(player) + "_down"):
		fire_canon(canon_down)
	if event.is_action_pressed("p" + str(player) + "_left"):
		fire_canon(canon_left)
	if event.is_action_pressed("p" + str(player) + "_right"):
		fire_canon(canon_right)

func fire_canon(canon):
	if canon.can_fire() :
		set_shield_off()
		canon.fire(bullet_spawner.get_bullet_instance(), player)
		
func set_shield_off():
	skin.get_node("shield").hide()
	shield_active = false
	cooldown.start()

func set_shield_on():
	skin.get_node("shield").show()
	shield_active = true

func _on_cooldown_timeout():
	set_shield_on()

func _on_shield_body_enter( body ):
	if shield_active:
		body.queue_free()

func _on_hitbox_body_enter( body ):
	if not shield_active and body.player != player :
		get_hurt(body)
		body.queue_free()
		
func get_hurt(bullet):
	#todo bullet strength
	life -= 1
	hit_particles.set_global_pos(bullet.get_global_pos())
	hit_particles.set_emitting(true)
	if life == 0:
		die()
	
func die():
	queue_free()
	emit_signal("died", player)
