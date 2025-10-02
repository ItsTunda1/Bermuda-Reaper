extends Control



var RadarDotScene = preload("res://UI/RadarDot.tscn")
@onready var radar_container = $CanvasLayer/RadarContainer
var radar_points = [Vector2(10, 20), Vector2(-50, 30)]

# Boat
var boat: boat;

func _ready():
	boat = get_node("../Boat")



@export var radar_size = Vector2(200, 200)
@export var radar_range = 1000.0  # Maximum distance shown on radar


func update_radar(points: Array):
	# Clear existing dots
	for child in radar_container.get_children():
		child.queue_free()

	# Add current
	for point in points:
		if (boat.position.distance_squared_to(Vector2(point))/1000 <= 100):
			var dot = RadarDotScene.instantiate()
			radar_container.add_child(dot)
			dot.position = convert_to_radar_position(point)

func convert_to_radar_position(world_offset: Vector2) -> Vector2:
	var normalized = world_offset / radar_range  # range -1 to 1
	var radar_pos = (normalized * (radar_size * 0.5))
	return radar_pos
	
	
func _process(_delta):
	var player_pos = Vector2(0, 0)
	radar_points[0].x += 10;
	
	
	var points = []

	for obj in get_tree().get_nodes_in_group("radar_objects"):
		var offset = obj.global_position - player_pos
		points.append(offset)

	update_radar(points)
