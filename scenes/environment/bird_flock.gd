extends Node3D

@export var base_speed := 0.06
@export var speed_jitter := 0.03

@export var bob_amp := 0.25
@export var bob_freq := 1.4

@export var flap_amp := 0.10       # scale amount
@export var flap_freq := 6.0       # "wingbeat" speed

@export var yaw_jitter_deg := 3.0  # subtle wobble
@export var yaw_freq := 0.8

@onready var path: Path3D = $Path3D

var followers: Array[PathFollow3D] = []
var speeds: Array[float] = []
var phases: Array[float] = []

func _ready() -> void:
    var rng = RandomNumberGenerator.new()
    rng.randomize()

    followers.clear()
    for child in path.get_children():
        if child is PathFollow3D:
            followers.append(child)

    speeds.resize(followers.size())
    phases.resize(followers.size())

    for i in followers.size():
        var f = followers[i]
        f.progress_ratio = float(i) / max(1.0, float(followers.size()))
        speeds[i] = base_speed + rng.randf_range(-speed_jitter, speed_jitter)
        phases[i] = rng.randf_range(0.0, TAU)

func _process(delta: float) -> void:
    var t := Time.get_ticks_msec() / 1000.0

    for i in followers.size():
        var f := followers[i]
        f.progress_ratio = fmod(f.progress_ratio + speeds[i] * delta, 1.0)

        if f.get_child_count() == 0:
            continue

        var bird := f.get_child(0) as Node3D
        if bird == null:
            continue

        # Bob (up/down)
        bird.position.y = sin(t * bob_freq + phases[i]) * bob_amp

        # Fake flap (scale squish)
        var flap := 1.0 + sin(t * flap_freq + phases[i]) * flap_amp
        bird.scale = Vector3(1.0, flap, 1.0)

        # Tiny yaw wobble so it feels alive
        var yaw := deg_to_rad(sin(t * yaw_freq + phases[i]) * yaw_jitter_deg)
        bird.rotation.y = yaw
