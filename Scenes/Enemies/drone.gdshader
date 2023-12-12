shader_type canvas_item;

uniform vec3 u_color: source_color = vec3(1);
uniform float u_progress: hint_range(0.0, 1.0, 0.1) = 0;

void fragment() {
	float currAlpha = texture(TEXTURE, UV).a;
	vec4 targetColor = mix(texture(TEXTURE, UV), vec4(u_color, currAlpha), u_progress);
	COLOR = targetColor;
		
}
