shader_type canvas_item;

uniform sampler2D disp_tex : hint_default_black;
uniform float speed : hint_range(0.0, 2.0);
uniform float intensity : hint_range(0.0, 0.1);

void fragment(){
	float t = TIME * speed;
	float disp = texture(disp_tex,fract( (UV+vec2(t,t)) )).r;
	vec4 color = texture(TEXTURE,UV+disp*intensity);
	COLOR = color;
}
