shader_type canvas_item;
uniform sampler2D wave: repeat_enable;
uniform vec2 tiling = vec2(5,5);
uniform float aspect_ratio = 0.5;
void fragment() {
	vec2 tiled_UV = UV * tiling;
	tiled_UV.y *= aspect_ratio;
	vec2 wave_move;
	wave_move.x = cos(TIME) * 0.3;
	wave_move.y = sin(TIME) * 0.3;
	COLOR= texture(wave, tiled_UV + wave_move);
	//COLOR = vec4(tiled_UV, 0, 1);
}
