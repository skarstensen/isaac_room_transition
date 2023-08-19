extends CharacterBody2D

@export var speed:int

var accept_input:bool = true

func _physics_process(delta):
	if (accept_input):
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = input_dir * speed

		move_and_slide()
