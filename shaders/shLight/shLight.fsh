varying vec2 pos;
varying vec4 col;

uniform vec2 u_pos;
uniform float zz;

void main(){
	vec2 dis = pos - u_pos;
	float str = 1./(sqrt(dis.x * dis.x + dis.y * dis.y + zz * zz) - zz);
    gl_FragColor = col * vec4(vec3(str), 1.);
}
