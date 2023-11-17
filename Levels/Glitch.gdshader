shader_type canvas_item;
render_mode unshaded;

uniform sampler2D displace : source_color;
uniform float dispAmt: hint_range(0.0, 1.0, 0.1);
uniform float abberationAMt: hint_range(0.0, 1.0, 0.1);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	
	vec4 disp = texture(displace, SCREEN_UV);
	vec2 newUV = SCREEN_UV * disp.xy *dispAmt;
	COLOR = texture(SCREEN_TEXTURE, newUV);
}
