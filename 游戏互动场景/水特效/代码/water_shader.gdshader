shader_type canvas_item;

uniform vec2 scale;
uniform vec2 mpos = vec2(-1.,-1.);
uniform float waveSize = 20.;
uniform float kTime = 0.0;
uniform float nowTime = 0.0;
uniform float speedOff = 3.0;
uniform vec3 mPosTime[100] ;

vec2 uvOff(vec2 pPos,vec2 mouse_pos,float kickTime){
	float linear = length(pPos-mouse_pos)/waveSize -(nowTime-kickTime)*(speedOff/1.);

	float disOff = (clamp(exp(-length(pPos-mouse_pos)/200.),0.05,1.0)-0.05)/0.95;
	float midOff = clamp(linear-0.5,-0.5,0.5);
	float mask = (1.0-abs(midOff)*2.);
//	float a = (1.0-abs(midOff)*2.)*sign(midOff);
	vec2 uv2 = disOff*mask*sin(-PI*midOff/2.0)*normalize(pPos-mouse_pos)*0.2;
	return uv2;
}

void fragment() {
	vec2 uv = UV;
//	vec2 mouse_uv = mouse_pos ;
	
	//拉伸变形校正
	float scale_min = scale.x/scale.y;
	vec2 uv_max = vec2(scale_min,1.);
	float trueScale;
	if(scale.y<scale.x){
		scale_min = scale.y/scale.x;
		uv.y = uv.y * scale_min;
		uv_max = vec2(1.,scale_min);
//		mouse_uv = mouse_pos * TEXTURE_PIXEL_SIZE /scale.x;
		trueScale = scale.x;
		}
	else{
		uv.x = uv.x*scale_min;
//		mouse_uv = mouse_pos * TEXTURE_PIXEL_SIZE /scale.y;
		trueScale = scale.y;
	}
	
	COLOR= texture(TEXTURE,uv);

	
	//鼠标响应
	vec2 pPos = uv / TEXTURE_PIXEL_SIZE * trueScale;
	vec2 left_bottom = vec2(0.,uv_max.y/TEXTURE_PIXEL_SIZE.y * trueScale);
	
	vec2 uv2 = vec2(0.);
	for (int i = 0; i < mPosTime.length(); i++) {
		if((mPosTime[i].x >0.)&&(mPosTime[i].y>0.))
		{
			float dis = float(i)/ceil(float(mPosTime.length()));
			uv2 += uvOff(pPos,vec2(mPosTime[i].x,mPosTime[i].y),mPosTime[i].z) * dis;
		}
	}
	
	COLOR = texture(TEXTURE,uv + uv2);
	// Place fragment code here.

//	FRAGCOORD.xy;
}