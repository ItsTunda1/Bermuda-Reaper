extends NinePatchRect

var depth := 1;

func prep_text(depthAmt : int):
	depth = depthAmt;
	$Depth.text = str(depthAmt) + " ft";
