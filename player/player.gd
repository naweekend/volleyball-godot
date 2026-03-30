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

func _physics_process(_delta: float) -> void:
	# Only handle INPUT here
	if player_idx == 1:
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color("e16540")
		sphere_001.set_surface_override_material(1, mat)
		input_dir = Input.get_axis("a", "d")
		if Input.is_action_just_pressed("w") and ground_ray.is_colliding():
			jump_queued = true
	elif player_idx == 2:
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color("55aa55")
		sphere_001.set_surface_override_material(1, mat)
		input_dir = Input.get_axis("left", "right")
		if Input.is_action_just_pressed("up") and ground_ray.is_colliding():
			jump_queued = true

# This is the "safe zone" for overriding RigidBody physics
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	# 1. Handle Jumping
	if jump_queued:
		# Use state.apply_central_impulse instead of the node's method
		state.apply_central_impulse(Vector3(0, JUMP_FORCE, 0))
		jump_queued = false
	
	# 2. Handle Snappy Movement
	# We get the current velocity from the 'state'
	var v = state.linear_velocity
	v.x = input_dir * SPEED
	
	# Apply it back to the state
	state.linear_velocity = v
