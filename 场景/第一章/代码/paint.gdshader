shader_type canvas_item;


uniform vec2 erase_points[2000];
uniform int erase_point_count = 0;
uniform float brush_size = 30.0;
uniform vec2 scale_ratio;
void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    for (int i = 0; i < erase_point_count; i++) {
		vec2 erase_uv = erase_points[i] * scale_ratio;
        if (distance(FRAGCOORD.xy, erase_uv) < brush_size * scale_ratio.x) {
            tex_color.a = 0.0;
			break;
        }
    }
    COLOR = tex_color;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

