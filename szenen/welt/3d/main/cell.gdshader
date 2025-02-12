shader_type canvas_item;  // For 2D grids; change to spatial if 3D

uniform float line_thickness : hint_range(0.01, 0.1) = 0.05;
uniform vec4 line_color = vec4(1.0, 1.0, 1.0, 1.0); // White border
uniform vec4 fill_color = vec4(0.0, 0.0, 0.0, 0.0); // Transparent fill

void fragment() {
    vec2 grid_uv = fract(UV * 10.0); // Adjust grid density (multiply UV to scale grid)
    float line = step(grid_uv.x, line_thickness) + step(grid_uv.y, line_thickness);
    line += step(1.0 - grid_uv.x, line_thickness) + step(1.0 - grid_uv.y, line_thickness);
    line = clamp(line, 0.0, 1.0);
    
    vec4 final_color = mix(fill_color, line_color, line);  // Mix fill and line colors
    COLOR = final_color;
}
