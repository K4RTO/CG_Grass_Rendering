#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
  mat4 view;
  mat4 proj;
}
camera;

layout(location = 0) in vec4 worldpos;
layout(location = 1) in vec3 worldnormal;
layout(location = 2) in vec2 tex_coords;

layout(location = 0) out vec4 outColor;

void main() {
  vec3 upper_color = vec3(0.3,0.9,0.1);
  vec3 lower_color = vec3(0.0,0.4,0.1);
  float ambient = 0.2;
  vec3 color1 = vec3(0.4, 0.9, 0.3);
  vec3 color2 = vec3( 0.2, 0.1, 0.2);

  vec3 diff = mix(color2, color1, tex_coords.y);
  vec3 lightDir = normalize(vec3(-1.0, 3.0, -2.0));

  vec3 lambert = diff *(clamp(dot(worldnormal, lightDir), 0.1, 1.0)+ ambient) ;

  vec3 col1 = vec3( 0.2, 0.1, 0.2);
  vec3 col2 = vec3(0.4, 0.9, 0.3);

  outColor = vec4(lambert,1);
}
