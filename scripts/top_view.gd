extends Node2D


@export var theBoat : boat;
@export var boatScene = preload("res://scenes/boat/boat.tscn")
#func _init():

func _ready():	
	var boaty = boatScene.instantiate()
	add_child(boaty)
	theBoat = boaty
	

func _process(delta):
	theBoat.move_in_direction()
	
