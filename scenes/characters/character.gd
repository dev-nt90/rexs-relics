class_name Character

extends CharacterBody3D

@export var base_speed: float = 8
@export var run_speed: float = 16

var movement_input: Vector2

@export var jump_height: float = 2.25
@export var jump_time_to_peak: float = 0.4
@export var jump_time_to_descent: float = 0.3

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = (
    (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)
) * -1

# TODO: animation
# TODO: combat?
# TODO: health/damage

var skin: Node3D

func apply_gravity(gravity, delta):
    velocity.y -= gravity * delta

func death_logic():
    pass
