extends Node



#									 ^
var n: int = 3; # Big triangle size /_\
var triangle_size: int = 300;	# Small tri sizes
var offset: Vector2 = Vector2(400, 400);

var dist_x = triangle_size/2;
var dist_y = triangle_size*sqrt(3)/4;
func place_triangles(layer: int, n: int, offset_x: int):
	print(layer)
	for i in layer:
		# Spawning
		var tile = preload("res://scenes/fish/fish2.tscn").instantiate();
		
		# Set dir (mirrored or not)
		if (i % 2 == 0):
			tile.scale.y = 1;
		else:
			tile.scale.y = -1;
		
		# Set Pos
		tile.position = Vector2(dist_x*i+offset_x+offset.x, -dist_y*n+offset.y);
		
		# Add to the main scene
		add_child(tile)
	return dist_x+offset_x;

# basic loop for each layer (progressively reaching the top (base case))
var start_loc: int = 0;

func _ready():
	for layer_idx in n/2+1:
		# place triangles
		var layer_size: int = (n-layer_idx*2);
		start_loc = place_triangles(layer_size, layer_idx, start_loc);  # FUNCTION CALL (func located AFTER MAIN BLOCK)
