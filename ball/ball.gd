extends RigidBody3D

@onready var ball_indicator: Sprite3D = $"../CanvasLayer/BallIndicator"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_rotation = true
	self.global_position = Vector3(randf_range(-8, 8), 13, 0)
	ball_indicator.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.global_position.y > 14:
		ball_indicator.visible = true
		ball_indicator.global_position = Vector3(self.global_position.x, 13.7, 0)
	else:
		ball_indicator.visible = false
