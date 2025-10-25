extends Sprite2D

class_name Diver
const speed_lower=0.
const speed_upper=0.6
const speed_step=0.1


var use_keyboard=true
var use_mouse=true
var hovering := false
const rotation_speed_target := 0.
const moving_speed_target := 2.5
const sprint_speed :=5
const aspeed_rot=0.01
const aspeed_mag=0.02
var speed_vec:= Vector2(0, 0)
const rotate_slowdown_threhold=30.

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
	
func is_sprint():
	return Input.is_action_pressed("sprint")
#
#func update_speed():
	#if Input.is_action_just_pressed("wheel_up"):
		#speed+=speed_step
	#if Input.is_action_just_released("wheel_down"):
		#speed-=speed_step
	#speed=clamp(speed,speed_lower,speed_upper)

var is_mouse_down = false  # Flag to check if the mouse was just pressed
func _process(delta):
	pass

func move_in_direction():
	var move_vec=get_input_vector()
	var speed_vec_normed=speed_vec.normalized()
	var angle_diff:=0.
	#position += move_dir * speed;
	if move_vec == Vector2(0.,0.) or speed_vec==Vector2(0.,0.):
		angle_diff=0.
	else:
		angle_diff=rad_to_deg(acos(speed_vec_normed.dot(move_vec.normalized())))
		
	var target_speed:=0.
	if angle_diff<=(30): # speed up to move forward
		target_speed=moving_speed_target
	else:
		target_speed=rotation_speed_target
		#print("Current angle difference is ", angle_diff)
		#print("Out of rotate_slowdown_threhold ", rotate_slowdown_threhold)
			#
	var move_vec_proj=move_vec.dot(speed_vec_normed)*speed_vec_normed # get vertical component		
	var move_vec_vert=move_vec-move_vec_proj
	#if angle_diff>=deg_to_rad(90):
	
	var new_speed_vec=(speed_vec_normed+move_vec_vert.normalized()*aspeed_rot).normalized()
	
	new_speed_vec=new_speed_vec*(speed_vec.length()*(1-aspeed_mag)+target_speed*aspeed_mag)
	if is_sprint():
		new_speed_vec=new_speed_vec.normalized()*sprint_speed;
	speed_vec=new_speed_vec
	rotation=speed_vec.angle()
	
	position += speed_vec;
	var vp = get_viewport_rect();
	position.x=max(position.x,0)
	position.x=min(position.x,vp.size.x)
	position.y=max(position.y,0)
	position.y=min(position.y,vp.size.y)
	print("Position: ", position)
	#print("vp: ", vp.size)
	#print("Move dir: ", move_vec)
	#print("Speed vec: ", speed_vec)
	#print("Speed: ", speed_vec.length())
	pass;
