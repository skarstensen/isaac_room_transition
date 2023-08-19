extends Node

@export var room_template:PackedScene

var current_room
var next_room

var current_room_tween
var next_room_tween

@onready var player = $"Room/Player"

func _ready():
	Messenger.TRIGGER_TRANSITION.connect(_on_transition_trigger)
	
	current_room = $"Room"


func _on_transition_trigger(direction):
	if (current_room_tween == null):
		next_room = room_template.instantiate()

		next_room.position = next_room.position + (Door.get_direction_vector(direction) * next_room.position)
		call_deferred("add_child", next_room)

		player.accept_input = false
		
		current_room_tween = create_tween()
		next_room_tween = create_tween()
		
		next_room_tween.tween_property(next_room, "position", current_room.position, 2)
		next_room_tween.tween_callback(func(): next_room_tween = null)
		current_room_tween.tween_property(current_room, "position", current_room.position - (Door.get_direction_vector(direction) * current_room.position), 2)
		current_room_tween.tween_callback(_on_transition_complete)
		current_room_tween.tween_callback(func(): current_room_tween = null)



func _on_transition_complete():
	current_room.remove_child(player)
	current_room.queue_free()

	current_room = next_room
	current_room.add_child(player)

	player.position = Vector2()
	player.accept_input = true
