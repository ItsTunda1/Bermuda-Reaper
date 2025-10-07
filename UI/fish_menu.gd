extends Control

class_name FishMenu




@onready var depthLineScene := preload("res://UI/Depth_Line.tscn");
@onready var fishContainerScene := preload("res://UI/Fish_Container.tscn");


@export var fishTypesBox : Control;
@export var pingBox : Control;
@export var depthContainer : Control;
@export var depthBarContainer : Control;
@export var mainSeparator : Control;

@export var depth : int = 10;

@export var depthHeight := 100.0;
@export var cosmeticDepthPerTick := 5.0;

#func _ready():
	#prep_fish_menu(depth);

func prep_fish_menu(inDepth):
	mainSeparator.size.y = depthHeight * inDepth;
	fishTypesBox.size.y = depthHeight * inDepth;
	pingBox.size.y = depthHeight * inDepth;
	depthContainer.size.y = depthHeight * inDepth;
	depthBarContainer.size.y = depthHeight * inDepth;
	for i in inDepth:
		prep_fish_container(i);
		prep_depth_line(i);
		pass;

func prep_fish_container(i):
	var newFishContainer = fishContainerScene.instantiate();
	newFishContainer.custom_minimum_size.y = depthHeight;
	fishTypesBox.add_child(newFishContainer)

func prep_depth_line(i):
	var depthLine = depthLineScene.instantiate();
	depthBarContainer.add_child(depthLine);
	depthLine.position.y = depthHeight * i;
	depthLine.custom_minimum_size.y = depthHeight;
	
	depthLine.prep_text((i) * cosmeticDepthPerTick)
