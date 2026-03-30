extends Node

var server = UDPServer.new()
var peers = []
@onready var player_1: RigidBody3D = $"../Player1"
@onready var player_2: RigidBody3D = $"../Player2"
var players = []

func _ready():
	players = [player_1, player_2]
	server.listen(4242)
	print("Server listening on port 4242")

func _process(delta):
	server.poll() # Important!
	print("PEERS " + str(peers))
	
	if server.is_connection_available():
		var peer = server.take_connection()
		# initial response
		var packet = peer.get_packet()
		peer.put_packet(packet)
		peers.append(peer)

	for i in range(peers.size()):
		var peer = peers[i]
		var player = players[i]
		if peers.size() <= players.size(): 
			while peer.get_available_packet_count() > 0:
				var packet = peer.get_packet().get_string_from_utf8()
				player.handle_cmd(packet)
