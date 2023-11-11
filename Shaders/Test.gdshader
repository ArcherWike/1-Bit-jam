shader_type canvas_item;
uniform vec4 color = vec4(1, 0, 0, 1);
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
void fragment() {
 vec4 curr_color = texture(screen_texture,SCREEN_UV); // Get current color of pixel
    if (curr_color == vec4(1,1,1,1)){
        COLOR = vec4(color);
    }else{
        COLOR = curr_color;
    }
}
