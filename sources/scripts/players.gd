
extends Node2D

var ship = preload("res://scenes/ship.tscn")

var players

signal player_died

func _ready():
	pass
	
func set_players(players):
	self.players = [] + players #duplicate
	
func clear_players():
	for child in get_children():
		child.queue_free()
	
func spawn_players():
	for i in range(players.size()):
		if players[i]:
			spawn_player(i)
	
func spawn_player(player_idx):
	var ship_inst = ship.instance()
	ship_inst.player = player_idx + 1
	ship_inst.connect("died", self, "_on_ship_died")
	ship_inst.set_global_pos(controler.get_level().get_node("ship" + str(ship_inst.player)).get_global_pos())
	add_child(ship_inst)

func get_first_alive_player_index():
	for i in range(players.size()):
		if players[i]:
			return i + 1
	return 0

func get_alive_players_count():
	var res = 0
	for i in range(players.size()):
		if players[i]:
			res += 1
	return res

func _on_ship_died(player_idx):
	players[player_idx - 1] = false
	emit_signal("player_died", player_idx)
