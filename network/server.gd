# Server.gd
extends Node
# Make sure this is an Autoload / Singleton

var server: UDPServer = UDPServer.new()
var peers: Array = []        # Connected clients
var players: Array = []      # Player nodes in the current scene
var sent_color_data := false

func _ready():
	# Start server
	server.listen(4242)
	print("Server listening on port 4242")

	# Connect scene changed signal to re-assign players
	get_tree().scene_changed.connect(_on_scene_changed)

func _on_scene_changed():
	# Called whenever the scene changes (including reloads)
	var scene = get_tree().current_scene
	if scene == null:
		return

	print("Scene loaded:", scene.name)
	sent_color_data = false
	if scene.has_node("ServerGame/Player1") and scene.has_node("ServerGame/Player2"):
		players = [
			scene.get_node("ServerGame/Player1"),
			scene.get_node("ServerGame/Player2")
		]
		print("Players assigned successfully!")

func _process(delta: float) -> void:
	server.poll()

	# Accept new connections
	while server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		# send an initial response to confirm
		peer.put_packet("CONNECTED".to_utf8_buffer())
		peers.append(peer)
		if not sent_color_data:
			peer.put_packet(("color" + str(peers.find(peer))).to_utf8_buffer())
			sent_color_data = true
		
		print("New peer connected. Total peers:", peers.size())

	# Process packets from each peer
	for i in range(peers.size()):
		if i >= players.size():
			# Not enough players in scene yet
			continue

		var peer: PacketPeerUDP = peers[i]
		var player = players[i]

		# Make sure player node still exists
		if player == null or not player.is_inside_tree():
			continue

		while peer.get_available_packet_count() > 0:
			var packet = peer.get_packet().get_string_from_utf8()
			player.handle_cmd(packet)
