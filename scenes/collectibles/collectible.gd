class_name Collectible

extends Area3D

@export var rotation_speed: float = 180.0
@export var bob_height: float = 0.2
@export var bob_speed: float = 5.0

@onready var start_y_pos: float = global_position.y

func _physics_process(delta: float) -> void:
    rotation.y += deg_to_rad(rotation_speed) * delta
    _bob_move(delta)
    
func _bob_move(delta: float) -> void:
    var time = Time.get_unix_time_from_system()
    var y_pos_offset = (1 + sin(time * bob_speed)) / 2*bob_height
    global_position.y = start_y_pos + y_pos_offset
