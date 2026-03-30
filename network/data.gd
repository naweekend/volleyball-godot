extends Control

@onready var fps_label: Label = $HBoxContainer/FPSLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("show_data"):
		self.visible = !self.visible
	
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
