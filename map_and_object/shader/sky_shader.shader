shader_type canvas_item;

uniform float speed = 0.01;


void fragment(){
	vec2 shift = UV;
	shift.x += TIME * speed;
	vec4 col = texture(TEXTURE, shift);
	COLOR = col;
}
