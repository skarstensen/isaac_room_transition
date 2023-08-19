extends Area2D

class_name Door

enum Compass { North, South, East, West }

@export var transition_direction:Compass

func _on_body_entered(body):
	Messenger.TRIGGER_TRANSITION.emit(transition_direction)


static func get_direction_vector(compass_direction) -> Vector2:
	match(compass_direction):
		Door.Compass.North:
			return Vector2(0, -2)
			
		Door.Compass.South:
			return Vector2(0, 2)
			
		Door.Compass.East:
			return Vector2(2, 0)
			
		Door.Compass.West:
			return Vector2(-2, 0)
	
	return Vector2()
