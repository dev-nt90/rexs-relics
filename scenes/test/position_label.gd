extends Label3D

@onready var parent = $".."

func _physics_process(delta: float) -> void:
    self.text = "Position (%d, %d, %d)" % \
    [parent.global_position.x, parent.global_position.y, parent.global_position.z]
