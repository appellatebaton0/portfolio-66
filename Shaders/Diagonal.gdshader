shader_type canvas_item;

uniform float threshold = 0.5;
uniform bool over = true;
uniform vec2 round_amnt = vec2(27., 20.);

bool pass(float value){
	if (over){return value > threshold * 2.;}
	else{     return value < threshold * 2.;}
}

void fragment() {
	
	if (pass(floor(SCREEN_UV.x * round_amnt.x) / round_amnt.x + floor(SCREEN_UV.y * round_amnt.y) / round_amnt.y)){
		COLOR.a = 0.0;
	}
	// Called for every pixel the material is visible on.
}



//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
