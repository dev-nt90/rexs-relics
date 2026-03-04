# model: Dino by Quaternius (https://poly.pizza/m/wuerCFCWNR)
# TODO: zoo UI to output the documentation
extends Character

@export var acceleration: float = 8
@export var braking: float = 4
@export var rotation_speed: float = 6

@onready var camera = $CameraController/Camera3D

func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # TODO figure out how to do this more elegantly
    skin = $PlayerSkin
    
func _physics_process(delta: float) -> void:
    move_logic(delta)
    jump_logic(delta)
    debug_mouse()
    move_and_slide()
    
    
func debug_mouse():
    if Input.is_action_just_pressed('ui_cancel'):
        if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
            Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
        else:
            Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
            
func move_logic(delta: float) -> void:
    movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down") \
    .rotated(-camera.global_rotation.y)
    
    var vel_2d = Vector2(velocity.x, velocity.z)
    if movement_input != Vector2.ZERO:
        var speed = base_speed #run_speed if Input.is_action_pressed("run") else base_speed TODO
        
        vel_2d += movement_input * speed * delta * acceleration
        vel_2d = vel_2d.limit_length(speed)
        velocity.x = vel_2d.x
        velocity.z = vel_2d.y
        var target_angle = -movement_input.angle() + (PI/2)
        skin.rotation.y = rotate_toward(skin.rotation.y, target_angle, delta * rotation_speed)
        #set_move_state('running') TODO
    else:
        vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed * delta * braking)
        velocity.x = vel_2d.x
        velocity.z = vel_2d.y
        # set_move_state('idle') TODO

func jump_logic(delta: float) -> void:
    if is_on_floor():
        if Input.is_action_just_pressed("jump"):
            velocity.y = -jump_velocity
            # set_move_state('jump') TODO
    #else:
        #set_move_state('Jump_Idle') TODO
    
    var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
    apply_gravity(gravity, delta)
