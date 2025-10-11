extends Node2D

const T_holdown=.5
@onready var fishlist=[$Fish1, $Fish2, $Fish3]
var press_time=0.0
var press_release=true
var fishing_range=100

func check_hold(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not press_release: return false
		press_time += delta
		if press_time > T_holdown:
			press_time = 0.0
			press_release=false
			return true
	else:
		press_release=true
		press_time = 0.0
	return false
	
func _process(delta):
	$Diver.move_in_direction()
	if check_hold(delta):
		print("check hold")
		var new_fishlist=[]
		for i in range(len(fishlist)):
			var fish_i=fishlist[i]
			print($Diver.position)
			print(fish_i.position)
			if $Diver.position.distance_to(fish_i.position)<fishing_range:
				print("Catch Fish!")
				print("Fish type:", fishlist[i])
				fishlist[i].queue_free()
			else:
				new_fishlist.append(fishlist[i])
		fishlist=new_fishlist
	
