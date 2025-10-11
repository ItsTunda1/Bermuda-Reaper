extends Area2D

class_name boat
const speed_lower=0.
const speed_upper=6.
const speed_step=1.

var use_keyboard=true
var use_mouse=true
var hovering := false
var speed = 3.

func _ready():
	# testing if cursor touch the boat. If touch, stop moving forward the cursor
	#mouse_entered.connect(func(): hovering = true)
	#mouse_exited.connect(func(): hovering = false)
	pass

func get_input_vector():
	var input_vector = Vector2.ZERO

	# Follow the mouse when no keyboard input is active
	if use_mouse:
		var mouse_pos = get_global_mouse_position()
		var to_mouse = mouse_pos - global_position
		# Avoid jitter when already at/near the mouse
		hovering = to_mouse.length()>=100
		if hovering: 
			input_vector = to_mouse.normalized()
	
	# Keyboard input
	if use_keyboard:
		if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			input_vector.x += 1

		if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			input_vector.x -= 1

		if Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
			input_vector.y += 1
		
		if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
			input_vector.y -= 1
		input_vector = input_vector.normalized()

	
	return input_vector

func update_speed():
	if Input.is_action_just_pressed("wheel_up"):
		speed+=speed_step
	if Input.is_action_just_released("wheel_down"):
		speed-=speed_step
	speed=clamp(speed,speed_lower,speed_upper)

var is_mouse_down = false  # Flag to check if the mouse was just pressed
func _process(delta):
	update_speed()
	move_in_direction();
	
	# radar call for mouse down
	# Check if the left mouse button is pressed and not already triggered
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not is_mouse_down:
		radar()
		is_mouse_down = true  # Set flag to prevent continuous calling

	# Reset flag when mouse button is released
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		is_mouse_down = false  # Allow the radar function to be called again next time

func move_in_direction():
	var move_dir=get_input_vector()
	position += move_dir * speed;
	if move_dir != Vector2(0.,0.):
		rotation=move_dir.angle()
	#print("Move dir: ", move_dir)
	#print("Speed: ", speed)
	pass;


# RADAR SYSTEM
#==============

func radar():
	# Fix spamming
	print("radar")
