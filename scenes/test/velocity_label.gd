extends Label3D

@onready var parent = $".."

func _physics_process(delta: float) -> void:
    self.text = "Velocity (%d, %d, %d)" % \
    [parent.velocity.x, parent.velocity.y, parent.velocity.z]
