shader_type canvas_item;

uniform vec4 color : source_color;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D noiseTexture;

void fragment() {
vec2 disortedUV = SCREEN_UV + texture(noiseTexture, UV).r * 0.005 ;
vec4 curr_color = texture(screen_texture, disortedUV);
float brightness = (curr_color.r + curr_color.g + curr_color.b);
vec4 grayScale = vec4(brightness, brightness, brightness, curr_color.a);
COLOR = grayScale * color;

}