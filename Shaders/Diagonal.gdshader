shader_type canvas_item;

uniform float threshold = 0.5;
uniform vec2 round_amnt = vec2(27., 20.);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	if (floor(SCREEN_UV.x * round_amnt.x) / round_amnt.x + floor(SCREEN_UV.y * round_amnt.y) / round_amnt.y > 2. * threshold){
		COLOR.a = 0.0;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
