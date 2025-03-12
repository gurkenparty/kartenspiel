shader_type spatial;
render_mode blend_mix, depth_draw_alpha_prepass;

uniform float speed = 2.0;
uniform vec4 fire_color : hint_color = vec4(1.0, 0.5, 0.0, 1.0);

void fragment() {
    vec2 uv = UV;
    
    // Create fire flicker effect using sine waves and UV distortion
    float noise = sin(uv.y * 10.0 + TIME * speed) * 0.5 + 0.5;
    noise *= smoothstep(0.0, 0.5, uv.y); // Fade flames at the top
    
    // Apply color and transparency
    ALBEDO = fire_color.rgb;
    ALPHA = noise;
}
