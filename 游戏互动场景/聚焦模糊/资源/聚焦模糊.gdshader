shader_type canvas_item;

uniform float rotation_speed : hint_range(0.0, 0.1); // 旋转速度
uniform float _Radius : hint_range(-5.0, 5.0);
uniform float y_rot : hint_range(-45, 45) = 0.0;
uniform float x_rot : hint_range(-45, 45) = 0.0;
uniform float fov : hint_range(1, 179) = 90;
uniform float inset : hint_range(0, 1) = 0.0;
varying flat vec2 o;
varying vec3 p;
vec2 customRotator(vec2 UVs,vec2 RotationCenter,float RotationAngle){
	vec2 _uv = UVs + RotationCenter * -1.0;
	float angle_cos = cos(RotationAngle);
	float angle_sin = sin(RotationAngle);
	vec2 _a = vec2(angle_cos,angle_sin * -1.0);
	vec2 _b = vec2(angle_sin,angle_cos);
	return vec2(dot(_uv,_a),dot(_uv,_b)) + RotationCenter;
}

vec4 Blur(sampler2D tex,vec2 uv, vec2 blurSize){
	float KERNEL_SIZE = 4.0;
	vec4 temp  = vec4(0.0);
	float sum = 0.0;
	float weight;
	vec2 texcood;
	for(float x = -KERNEL_SIZE/2.0; x <= KERNEL_SIZE/2.0; x++)
	{
    	for(float y = -KERNEL_SIZE/2.0; y <= KERNEL_SIZE/2.0; y++)
    	{
        	texcood = uv;
        	texcood.x += blurSize.x * x;
        	texcood.y += blurSize.y * y;
        	weight = 1.0/(abs(x)+abs(y)+2.0);
        	temp += texture(tex, texcood)*weight;
        	sum += weight;
    	}
	}
	return temp / sum;
}
void vertex(){
	float sin_b = sin(y_rot / 180.0 * PI);//计算绕 Y 轴旋转角度 y_rot 的正弦值。
	float cos_b = cos(y_rot / 180.0 * PI);//计算绕 Y 轴旋转角度 y_rot 的余弦值。
	float sin_c = sin(x_rot / 180.0 * PI);//计算绕 X 轴旋转角度 x_rot 的正弦值
	float cos_c = cos(x_rot / 180.0 * PI);//计算绕 X 轴旋转角度 x_rot 的余弦值
	mat3 inv_rot_mat;
	inv_rot_mat[0][0] = cos_b;
	inv_rot_mat[0][1] = 0.0;
	inv_rot_mat[0][2] = -sin_b;
	inv_rot_mat[1][0] = sin_b * sin_c;
	inv_rot_mat[1][1] = cos_c;
	inv_rot_mat[1][2] = cos_b * sin_c;
	inv_rot_mat[2][0] = sin_b * cos_c;
	inv_rot_mat[2][1] = -sin_c;
	inv_rot_mat[2][2] = cos_b * cos_c;
	float t = tan(fov / 360.0 * PI);
	p = inv_rot_mat * vec3((UV - 0.5), 0.5 / t);
	float v = (0.5 / t) + 0.5;
	p.xy *= v * inv_rot_mat[2].z;
	o = v * inv_rot_mat[2].xy;

	VERTEX += (UV - 0.5) / TEXTURE_PIXEL_SIZE * t * (1.0 - inset);
}
void fragment() {
    // 计算旋转角度
    float angle = TIME * rotation_speed * 6.28318; // 2*PI
	vec2 uv = (p.xy / p.z).xy - o;
	vec2 uv_ = uv;
	uv_ = customRotator(uv_,vec2(0,0),angle);
	vec4 color = Blur(TEXTURE,uv_ + 0.5,_Radius*TEXTURE_PIXEL_SIZE.xy);
	COLOR = color;
	COLOR.a *= step(max(abs(uv_.x), abs(uv_.y)), 0.5);
}
