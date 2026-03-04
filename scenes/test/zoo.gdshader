shader_type spatial;

// Uniforms allow you to change colors and scale in the inspector
uniform vec4 color1 : source_color = vec4(1.0);
uniform vec4 color2 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float size = 1.0;

varying vec3 world_pos;

void vertex() {
    // Calculate world position to pass to fragment shader
    world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
    // Use world position and modulo to create a grid pattern
    vec3 checker_coord = floor(world_pos / size);
    float checker = mod(checker_coord.x + checker_coord.y + checker_coord.z, 2.0);
    
    // Mix colors based on checker pattern
    vec4 final_color = mix(color1, color2, step(0.5, checker));
    ALBEDO = final_color.rgb;
}