#version 320 es
precision mediump float;

uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / vec2(textureSize(tex, 0));
    vec4 color = texture(tex, uv);
    vec3 c = color.rgb;
    c = pow(c, vec3(0.82));
    float luma = dot(c, vec3(0.2126, 0.7152, 0.0722));
    c = mix(vec3(luma), c, 1.4);
    c = max(c - 0.02, 0.0) / (1.0 - 0.02);
    fragColor = vec4(c, color.a);
}
