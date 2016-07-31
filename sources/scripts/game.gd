
extends Node

onready var level = get_node("level")
onready var players = get_node("players")
onready var pause_screen = get_node("pause_screen")

var players_list
var players_skins

func _ready():
	pass

func set_players_list(players_list, players_skins):
	self.players_list = players_list
	self.players_skins = players_skins
	reset()

func reset():
	players.clear_players()
	level.clear_bullets()
	players.set_players(players_list, players_skins)

func start():
	players.spawn_players()

func _on_players_player_died(player_idx):
	print("player " + str(player_idx) + " diededed")
	if players.get_alive_players_count() < 2 :
		game_over()

func game_over():
	var winner = players.get_first_alive_player_index()
	if winner == 0 :
		print("draw")
	else :
		print("player " + str(winner) + " won !")
	restart()

func restart():
	reset()
	start()