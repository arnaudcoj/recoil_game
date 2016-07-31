
extends RigidBody2D

export var player = 1
export var ship_recoil_multiplier = 2
export var bullet_impulse_multiplier = 10

signal died

var shield_active = true

var bullet = preload("res://scenes/bullet.tscn")
var bullet_gd = preload("res://scripts/bullet.gd")

onready var canons = get_node("canons")

onready var canon_up = canons.get_node("canon_up")
onready var canon_down = canons.get_node("canon_down")
onready var canon_left = canons.get_node("canon_left")
onready var canon_right = canons.get_node("canon_right")

onready var shield = get_node("shield")

onready var cooldown = get_node("cooldown")

onready var skin = get_node("skin")

func _ready():
	set_process_input(true)
	get_node("player_name").set_text(str(player))

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
	if shield_active :
		set_shield_off()
		var impulse = canon.get_global_pos() - get_global_pos()
		apply_impulse(Vector2(0,0), -impulse * ship_recoil_multiplier)
		var i_bullet = bullet.instance()
		i_bullet.player = player
		controler.get_level().add_bullet(i_bullet)
		i_bullet.set_global_pos(canon.get_global_pos())
		i_bullet.set_rot(canon.get_rot() + get_rot())
		i_bullet.apply_impulse(Vector2(0,0), impulse * bullet_impulse_multiplier)
		


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
		die()
	
func die():
	queue_free()
	emit_signal("died", player)
