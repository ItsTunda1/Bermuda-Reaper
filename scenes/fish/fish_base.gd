extends Node2D


var fish_name: String;
# Normal Distribution
var std: float = 10;
var mean: int = 100;

# Ranges
var min: int;
var max: int;

func NormalDistribution(x: int):
	# 1.0 to keep float
	var e_part: float = -1.0/2 * ((x - mean)/std)**2;
	return (1 / std) * exp(e_part);
	
func _ready():
	print(NormalDistribution(101));
	
	
# Calc the min and max range
# (1/std)^((-1/2)*((X-m)/s)^2) >= 0.015
# https://www.desmos.com/calculator/ew3hecawoo
