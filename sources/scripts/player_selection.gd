
extends Panel

signal start
onready var player1 = get_node("player1")
onready var player2 = get_node("player2")
onready var player3 = get_node("player3")
onready var player4 = get_node("player4")

func _ready():
	pass
	
func get_players_list():
	return [player1.selected, player2.selected, player3.selected, player4.selected]

func get_players_skins():
	return [player1.skin.duplicate(), player2.skin.duplicate(), player3.skin.duplicate(), player4.skin.duplicate()]
	
func get_players_count():
	var players = get_players_list()
	var res = 0
	for i in range(players.size()):
		if players[i]:
			res += 1
	#print(res)
	return res

func start():
	if get_players_count() >= 2:
		emit_signal("start", get_players_list(), get_players_skins())

func _on_player_start():
	start()
