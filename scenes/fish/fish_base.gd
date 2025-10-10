extends Node2D

class_name Fish_Base


@export var fish_name: String;
# Normal Distribution
var std: float = 10;
var mean: int = 100;

# Ranges
@export var min: int;
@export var max: int;
@export var object = true;

func NormalDistribution(x: int):
	# 1.0 to keep float
	var e_part: float = -1.0/2 * ((x - mean)/std)**2;
	return (1 / std) * exp(e_part);
	
func _ready():
	print(NormalDistribution(101));
	
	# Show on Radar
	if (object):
		add_to_group("radar_objects")
	
func Swim_Behavior():
	#print("Fishy")
	position.x += 1;
	position.y += 0.2;
	
func Radar_Behavior():
	print("Fishy")
	
	
	
	
#func _process(_delta):
#	Swim_Behavior()
	
	
# Calc the min and max range
# (1/std)^((-1/2)*((X-m)/s)^2) >= 0.015
# https://www.desmos.com/calculator/ew3hecawoo
