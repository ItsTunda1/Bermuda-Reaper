extends Control



var RadarDotScene = preload("res://UI/RadarDot.tscn")
@onready var radar_container = $CanvasLayer/RadarContainer

# Wiper Anim
var wiper_angle: float = 0.0;
@onready var wiper = $CanvasLayer/RadarContainer/Wiper

# Boat
var boat: boat;

func _ready():
	boat = get_node("../Boat")



@export var radar_size = Vector2(200, 200)
@export var radar_range = 1000.0  # Maximum distance shown on radar


func update_radar(points: Array):
	'# Clear existing dots
	for child in radar_container.get_children():
		child.queue_free()'

	# Add current
	for point in points:
		if (boat.position.distance_squared_to(Vector2(point))/1000 <= 1000):
			# Check angle (show if overlap with wiper)
			#point += boat.position
			point.x -= 550
			point.y -= 500
			#print(point)
			#print(rad_to_deg(point.angle()))
			#print("=============")
			var angle_to_origin = rad_to_deg(point.angle()) + 270.0+50;	# Flip & Offset by 90 so that it matches the wiper
			if (angle_to_origin >= 360):
				angle_to_origin = 0.0;
			point.x += 550
			point.y += 500
			#print(angle_to_origin)
			#print(wiper_angle)
			#print("==================")
			if (abs(angle_to_origin - wiper_angle) <= 1.0):
				var dot = RadarDotScene.instantiate()
				radar_container.add_child(dot)
				dot.position = convert_to_radar_position(point)

func convert_to_radar_position(world_offset: Vector2) -> Vector2:
	var normalized = world_offset / radar_range  # range -1 to 1
	var radar_pos = (normalized * (radar_size * 0.5))
	return radar_pos
	
	

var fish_types = {"A": 10, "B": 15}
var radar_depth = 12
func Grab_Fish():
	var possible_fish;
	for fish in fish_types:
		if (radar_depth >= fish):
			possible_fish.append(fish)
	
	# random pick 2-3
	
	
func _process(delta):
	var player_pos = boat.position
	
	
	var points = []

	for obj in get_tree().get_nodes_in_group("radar_objects"):
		var offset = obj.global_position - player_pos
		offset.x += 550
		offset.y += 500
		points.append(offset)

	update_radar(points)
	
	# Move Wiper
	wiper.rotation_degrees = wiper_angle;
	wiper_angle += 2.0;
	if (wiper_angle >= 360.0):
		wiper_angle = 0.0;
