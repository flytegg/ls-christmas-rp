#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void position(float y1, float y2, float y3, float y4){
    float scale = ProjMat[0][0] * ScreenSize.x * 0.5;
    if(scale == 4.0){
        gl_Position.y = gl_Position.y - y1;
        gl_Position.x = gl_Position.x - 0.49;
        gl_Position.z = 0.0;
    }else if(scale == 3.0){
        gl_Position.y = gl_Position.y - y2;
        gl_Position.x = gl_Position.x - 0.37;
        gl_Position.z = 0.0;
    }else if(scale == 2.0){
        gl_Position.y = gl_Position.y - y3;
        gl_Position.x = gl_Position.x - 0.248;
        gl_Position.z = 0.0;
    }else if(scale == 1.0){
        gl_Position.y = gl_Position.y - y4;
        gl_Position.x = gl_Position.x - 0.125;
        gl_Position.z = 0.0;
    }
}

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);

    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;

    // NoShadow behavior (https://github.com/PuckiSilver/NoShadow)
    if (Color.xyz == vec3(78/255., 92/255., 36/255.) && (Position.z == 0.03 || Position.z == 0.06 || Position.z == 0.12)) {
        vertexColor.rgb = texelFetch(Sampler2, UV2 / 16, 0).rgb; // remove color from no shadow marker
    } else if (Color.xyz == vec3(19/255., 23/255., 9/255.) && Position.z == 0) {
        gl_Position = vec4(2,2,2,1); // move shadow off screen
    }

    if(vertexColor.r >= 0.9882 && vertexColor.r <= 0.9999){
        if(vertexColor.g >= 0.3294 && vertexColor.g <= 0.33){
            if(vertexColor.b >= 0.3294 && vertexColor.b <= 0.33){
                if(gl_Position.x > 0.9){
                    vertexColor.a = 0.0;
                }
            }
        }
    }

    if(true){
        if(Color.xyz == vec3(12/255., 13/255., 0.0)){
            vertexColor.r = 1.0;
            vertexColor.g = 1.0;
            vertexColor.b = 1.0;
            vertexColor.a = 1.0;
            position(0.12, 0.09, 0.06, 0.03);
        }else if(Color.xyz == vec3(12/255., 13/255., 1/255.)){
            vertexColor.r = 1.0;
            vertexColor.g = 1.0;
            vertexColor.b = 1.0;
            vertexColor.a = 1.0;
            position(0.25, 0.19, 0.12, 0.06);
        }else if(Color.xyz == vec3(12/255., 13/255., 2/255.)){
            vertexColor.r = 1.0;
            vertexColor.g = 1.0;
            vertexColor.b = 1.0;
            vertexColor.a = 1.0;
            position(0.38, 0.29, 0.19, 0.095);
        }else if(Color.xyz == vec3(12/255., 13/255., 3/255.)){
            vertexColor.r = 1.0;
            vertexColor.g = 1.0;
            vertexColor.b = 1.0;
            vertexColor.a = 1.0;
            position(0.52, 0.39, 0.26, 0.125);
        }else if(Color.xyz == vec3(12/255., 13/255., 4/255.)){
            vertexColor.r = 1.0;
            vertexColor.g = 1.0;
            vertexColor.b = 1.0;
            vertexColor.a = 1.0;
            position(0.65, 0.49, 0.32, 0.160);
        }else if(Color.xyz == vec3(12/255., 13/255., 5/255.)){
            vertexColor.r = 1.0;
            vertexColor.g = 1.0;
            vertexColor.b = 1.0;
            vertexColor.a = 1.0;
            position(0.78, 0.59, 0.39, 0.195);
        }else if(Color.xyz == vec3(12/255., 13/255., 6/255.)){
            vertexColor.r = 1.0;
            vertexColor.g = 1.0;
            vertexColor.b = 1.0;
            vertexColor.a = 1.0;
            position(0.22, 0.69, 0.47, 0.03);
        }else if(Color.xyz == vec3(12/255., 13/255., 7/255.)){
            vertexColor.r = 1.0;
            vertexColor.g = 1.0;
            vertexColor.b = 1.0;
            vertexColor.a = 1.0;
            position(0.22, 0.79, 0.53, 0.03);
        }
    }
    
}