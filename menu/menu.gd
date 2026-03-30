extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_keyboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/main.tscn")


func _on_phone_button_pressed() -> void:
	get_tree().change_scene_to_file("res://network/server_main.tscn")
