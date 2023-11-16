shader_type canvas_item;
uniform float alpha = 0.8;
uniform float complete = 1;
void fragment() {
vec4 curr_color = texture(TEXTURE, UV);
vec4 color = vec4(1,1,1,1)* vec4(alpha ,alpha ,alpha ,1);
COLOR = (curr_color * color*complete);
}
