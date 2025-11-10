extends CharacterBody3D

const ORIGINAL_SPEED = 5
const SPRINT_SPEED = 8
var speed = ORIGINAL_SPEED
const JUMP_VELOCITY = 9

@onready var player_camera: Camera3D = $camera_controller/player_camera

var camera_rotation_x: float = 0.0
var camera_rotation_y: float = 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera_rotation_x = player_camera.rotation.x
	camera_rotation_y = rotation.y

func _process(_delta):
	if Input.is_action_just_pressed("flash_light"):
		$flash_light.visible = !$flash_light.visible

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_delta = event.relative
		camera_rotation_y -= mouse_delta.x * 0.005 # 控制角色左右转身
		camera_rotation_x -= mouse_delta.y * 0.005 # 控制相机上下俯仰
		camera_rotation_x = clamp(camera_rotation_x, -1.5, 0.6) # 根据需要调整角度
		rotation.y = camera_rotation_y
		player_camera.rotation.x = camera_rotation_x
	if Input.is_action_just_pressed("ui_cancel"): # "ui_cancel" 通常是 ESC 键
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # 让光标可见
		get_tree().set_pause(true) # 可选：暂停游戏，进入菜单
	if Input.is_action_just_pressed("sprint"):
		speed = SPRINT_SPEED
	if Input.is_action_just_released("sprint"):
		speed = ORIGINAL_SPEED


func player_base_move(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var input_dir := Input.get_vector("ui_right","ui_left",  "ui_down","ui_up" )
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()

func _physics_process(delta: float) -> void:
	player_base_move(delta)
	global.debug.add_property("speed",speed,1)

func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
