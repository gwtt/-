shader_type canvas_item;

uniform float flip_progress = 0.0; // 翻页进度，0.0到1.0
uniform vec2 page_size = vec2(1024.0, 768.0); // 页面的尺寸

void vertex() {
    // 获取当前顶点的位置
    vec2 vertex_pos = VERTEX;
    
    // 计算翻页效果
    float flip_angle = mix(0.0, 3.14159265, flip_progress);
    float flip_radius = page_size.x * 0.5;
    
    // 计算顶点相对于页面中心的位置
    vec2 center = (page_size * 0.5);
    vertex_pos -= center;
    
    // 计算翻页时的旋转角度
    float angle = atan(vertex_pos.y, vertex_pos.x) + flip_angle;
    
    // 应用旋转
    vertex_pos = vec2(cos(angle), sin(angle)) * length(vertex_pos);
    
    // 将顶点位置放回原位
    vertex_pos += center;
    
    // 应用顶点位置
    VERTEX = vertex_pos;
}

void fragment() {
    vec4 color = vec4(1.0, 1.0, 1.0, 1.0);
    COLOR = color;
}

