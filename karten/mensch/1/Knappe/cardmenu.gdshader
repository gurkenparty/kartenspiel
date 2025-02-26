shader_type canvas_item;

void fragment() {
    vec2 uv_centered = UV - vec2(0.5); // Center UVs
    float dist = length(uv_centered);  // Distance from center
    if (dist > 0.5) { 
        discard;  // Remove pixels outside the circle
    }
}