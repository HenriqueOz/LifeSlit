//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float bright;


void main()
{
	vec4 baseColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ); 
    gl_FragColor = vec4(baseColor.rgb + bright, baseColor.a);
}
