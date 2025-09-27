extends Node2D

@export var theFish : fish;

@export var fishScene = preload("res://fish.tscn");

#func _init():

func _ready():
	var fishy = fishScene.instantiate()
	add_child(fishy);
	theFish = fishy;

func _process(delta):
	theFish.swim_in_direction(Vector2(1,1));
