shader_type spatial;
render_mode unshaded;

uniform sampler2D noise_texture; // Noise texture for cloud details
uniform float speed = 0.1;       // Speed of cloud movement
uniform float cloud_density = 0.6; // Density of clouds (0-1)
uniform vec3 cloud_color = vec3(0.8, 0.8, 0.8); // Cloud color (recognized as color in the editor)
uniform float coverage = 0.5;    // Overall cloud coverage
uniform float time_scale = 0.5;  // How fast clouds evolve

void fragment() {
    vec2 uv = UV;

    // Move the noise texture over time to simulate cloud movement
    float time_offset = TIME * speed;
    vec2 moving_uv = uv + vec2(time_offset * 0.1, time_offset * 0.05);

    // Sample the noise texture for cloud formation
    float noise_value = texture(noise_texture, moving_uv).r;

    // Adjust noise to create cloud density and coverage effects
    float cloud_mask = smoothstep(coverage, coverage + 0.1, noise_value * cloud_density);

    // Mix cloud color based on mask intensity
    vec3 final_color = mix(vec3(0.0), cloud_color, cloud_mask);

    // Output color
    ALBEDO = final_color;
    ALPHA = cloud_mask; // Adjust transparency for soft cloud edges
}
