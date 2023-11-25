#version 150

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;

in vec2 texCoord0;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
    if (color.a == 0.0) {
        discard;
    }

    if(color.r == 1. && color.g >= 0.333333333 && color.g <= 0.3333334 && color.b >= 0.333333333 && color.b <= 0.3333334){
        discard;
    }

    fragColor = color * ColorModulator;
}