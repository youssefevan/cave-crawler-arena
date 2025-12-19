shader_type canvas_item;

uniform bool active = false;
uniform vec4 input_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 new_color = previous_color;
	if (active == true)
	{
		new_color = input_color;
	}
	
	if (COLOR != vec4(0.0, 0.0, 0.0, 1.0) && COLOR.a != 0.0)
	COLOR = new_color;
}