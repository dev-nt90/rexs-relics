extends Collectible


func _on_body_entered(body: Node3D) -> void:
    if not body.is_in_group('player'):
        return 
    
    print('player entered collectible')
