extends Fish_Base

class_name Fish_Lionfish

func Swim_Behavior():
	#print("Fishy")
	position.x += 1;
	position.y += 0.2;

var timer: float = 0.0;
var wait_time: float = randf_range(3, 5);
var target_pos: Vector2 = position;
func Radar_Behavior():
	if (timer >= wait_time):
		var pos = position;
		var range: float = 500;
		target_pos.x = randf_range(pos.x - range, pos.x + range);
		target_pos.y = randf_range(pos.y - range, pos.y + range);
		timer = 0.0;
		wait_time = randf_range(3, 5);
	
	position = lerp(position, target_pos, 0.01);
	
	
	
	
func _process(_delta):
	#Swim_Behavior()
	Radar_Behavior()
	timer += _delta;


func _on_area_entered(area: Area2D) -> void:
	if (area is boat):
		print("Entered")


func _on_area_exited(area: Area2D) -> void:
	if (area is boat):
		print("Exited")
