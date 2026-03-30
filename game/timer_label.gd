extends Label

@onready var timer: Timer = $"../../Timer"
@onready var player_1: RigidBody3D = $"../../Player1"
@onready var player_2: RigidBody3D = $"../../Player2"
@onready var ball: RigidBody3D = $"../../Ball"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = true
	player_1.freeze = true
	player_2.freeze = true
	ball.freeze = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not int(timer.time_left) <= 0:
		self.text = str(int(timer.time_left))
	else:
		self.text = "GO!"
		

func _on_timer_timeout() -> void:
	player_1.freeze = false
	player_2.freeze = false
	ball.freeze = false
	self.visible = false
