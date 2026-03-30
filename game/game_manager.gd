extends Node

const GAME_TSCN = preload("uid://bivv5cmy6k6sj")

var player_1_points: int = 0
var player_2_points: int = 0
#@onready var player_1_label = get_tree().root.get_node("UIOverlay/Player1Label")
#@onready var player_2_label = $"../UIOverlay/Player2Label"
var player_1_label: Label
var player_2_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(player_1_points, player_2_points)
	pass

func add_point(player_idx: int):
	if player_idx == 1:
		player_1_points += 1
	elif player_idx == 2:
		player_2_points += 1
	call_deferred("_reload_scene")
	
func _reload_scene():
	get_tree().reload_current_scene()

func update_labels():
	var root = get_tree().current_scene
	var ui = root.get_node("UIOverlay")  # your UIOverlay node
	player_1_label = ui.get_node("Player1Label")
	player_2_label = ui.get_node("Player2Label")
	player_1_label.text = str(player_1_points)
	player_2_label.text = str(player_2_points)
