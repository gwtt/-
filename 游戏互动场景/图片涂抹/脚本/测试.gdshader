shader_type canvas_item;

// 遮罩纹理，用于记录透明度
uniform sampler2D mask_texture;

// 画笔的半径
uniform float brush_radius = 0.1;

// 鼠标位置，以UV坐标表示
uniform vec2 mouse_position;

void fragment() {
    // 获取当前像素的颜色
    vec4 tex_color = texture(TEXTURE, UV);

    // 获取遮罩纹理中当前像素的Alpha值
    float mask_alpha = texture(mask_texture, UV).r;

    // 如果遮罩中的Alpha值为0，则使当前像素完全透明
    if (mask_alpha == 0.0) {
        tex_color.a = 0.0;
    }

    COLOR = tex_color;
}
