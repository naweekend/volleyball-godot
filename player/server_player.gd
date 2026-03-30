extends RigidBody3D

var SPEED = 13.0
var JUMP_FORCE = 12.0
@export_range(1, 2, 1) var player_idx: int = 1

var jump_queued = false
var input_dir = 0.0

@onready var ground_ray: RayCast3D = $GroundRay
@onready var sphere_001: MeshInstance3D = $"character-red/Sphere_001"

func _ready() -> void:
	lock_rotation = true
	print("server player")

	# Set player color once (not every frame)
	var mat = StandardMaterial3D.new()

	if player_idx == 1:
		mat.albedo_color = Color("e16540")
	else:
		mat.albedo_color = Color("55aa55")

	sphere_001.set_surface_override_material(1, mat)


# Physics movement (NO keyboard input here anymore)
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:

	# Jump
	if jump_queued and ground_ray.is_colliding():
		state.apply_central_impulse(Vector3(0, JUMP_FORCE, 0))
		jump_queued = false

	# Horizontal movement
	var v = state.linear_velocity
	v.x = input_dir * SPEED
	state.linear_velocity = v


# This is called by the server when a packet arrives
func handle_cmd(cmd: String):
	match cmd:
		"LEFT_PRESSED":
			input_dir = -1
		"LEFT_RELEASED":
			if input_dir < 0:
				input_dir = 0
		"RIGHT_PRESSED":
			input_dir = 1
		"RIGHT_RELEASED":
			if input_dir > 0:
				input_dir = 0
		"JUMP_PRESSED":
			jump_queued = true
