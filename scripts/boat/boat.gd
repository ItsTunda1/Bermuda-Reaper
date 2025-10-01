extends Sprite2D

class_name boat
var speed = 3


func _ready():
	pass;

func get_input_vector():
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		input_vector.x += 1
		flip_h = false  # 朝右时不翻转
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		input_vector.x -= 1
		flip_h = true   # 朝左时翻转
	if Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		input_vector.y += 1
		
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		input_vector.y -= 1
	
	return input_vector
	
var is_mouse_down = false  # Flag to check if the mouse was just pressed
func _process(delta):
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
	position += move_dir.normalized() * speed;
	if move_dir != Vector2(0.,0.):
		rotation=move_dir.angle()
	pass;








# RADAR SYSTEM
#==============

func radar():
	# Fix spamming
	print("radar")
