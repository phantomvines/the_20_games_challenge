shader_type canvas_item;
render_mode unshaded, blend_add;

// definitions of variables
uniform vec4 alive_colour = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 dead_colour = vec4(0.0, 0.0, 1.0, 1.0);
uniform float glow_strength = 3.0;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_colour = texture(TEXTURE, UV);
	
	if (tex_colour.a < 0.1)
	{
		discard;
	}
	
	float brightness = tex_colour.r + tex_colour.g + tex_colour.b;
	float is_alive = step(0.1, brightness);
	
	vec4 colour = mix(dead_colour, alive_colour, is_alive);
	colour.rgb *= glow_strength;
	
	COLOR = colour;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
