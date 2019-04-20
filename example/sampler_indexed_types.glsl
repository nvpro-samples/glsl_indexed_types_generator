// auto-generated file by glsl_indexed_types_generator.lua
// indexType: uint16_t

// resource descriptorsets
layout(set=DIT_DSET_IDX + 0, binding=0) uniform sampler2D dit_sampler2D[];
layout(set=DIT_DSET_IDX + 1, binding=0) uniform texture2D dit_texture2D[];
layout(set=DIT_DSET_IDX + 2, binding=0) uniform usamplerBuffer dit_usamplerBuffer[];

// resource indexing structs
struct sampler2D_u16{ uint16_t idx; };
struct texture2D_u16{ uint16_t idx; };
struct usamplerBuffer_u16{ uint16_t idx; };

// sampler constructors
sampler2D c_sampler2D(sampler2D_u16 s){ return dit_sampler2D[nonuniformEXT(uint(s.idx))]; }
sampler2D c_sampler2D(texture2D_u16 t, sampler s){ return sampler2D(dit_texture2D[nonuniformEXT(uint(t.idx))], s); }
usamplerBuffer c_usamplerBuffer(usamplerBuffer_u16 s){ return dit_usamplerBuffer[nonuniformEXT(uint(s.idx))]; }

// function overrides
#if DIT_GL_ARB_sparse_texture2
int sparseTextureARB(sampler2D_u16 s, vec2 arg1, out vec4 arg2, float arg3){return sparseTextureARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
#endif
#if DIT_GL_ARB_sparse_texture_clamp
int sparseTextureClampARB(sampler2D_u16 s, vec2 arg1, float arg2, out vec4 arg3){return sparseTextureClampARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
int sparseTextureClampARB(sampler2D_u16 s, vec2 arg1, float arg2, out vec4 arg3, float arg4){return sparseTextureClampARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
#endif
#if DIT_GL_ARB_sparse_texture2
int sparseTextureGatherARB(sampler2D_u16 s, vec2 arg1, out vec4 arg2, int arg3, float arg4){return sparseTextureGatherARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
#endif
#if DIT_GL_ARB_sparse_texture_clamp
int sparseTextureGradClampARB(sampler2D_u16 s, vec2 arg1, vec2 arg2, vec2 arg3, float arg4, out vec4 arg5){return sparseTextureGradClampARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4, arg5); }
#endif
vec4 texture(sampler2D_u16 s, vec2 arg1, float arg2){return texture(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
#if DIT_GL_ARB_sparse_texture_clamp
vec4 textureClampARB(sampler2D_u16 s, vec2 arg1, float arg2){return textureClampARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec4 textureClampARB(sampler2D_u16 s, vec2 arg1, float arg2, float arg3){return textureClampARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
vec4 textureGradClampARB(sampler2D_u16 s, vec2 arg1, vec2 arg2, vec2 arg3, float arg4){return textureGradClampARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
#endif
vec4 textureProj(sampler2D_u16 s, vec3 arg1, float arg2){return textureProj(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec4 textureProj(sampler2D_u16 s, vec4 arg1, float arg2){return textureProj(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec2 textureQueryLod(sampler2D_u16 s, vec2 arg1){return textureQueryLod(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1); }
#if DIT_GL_ARB_sparse_texture2
int sparseTexelFetchARB(sampler2D_u16 s, ivec2 arg1, int arg2, out vec4 arg3){return sparseTexelFetchARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
int sparseTexelFetchARB(texture2D_u16 s, ivec2 arg1, int arg2, out vec4 arg3){return sparseTexelFetchARB(dit_texture2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
#endif
int sparseTexelGradFetchARB(sampler2D_u16 s, ivec2 arg1, int arg2, vec2 arg3, vec2 arg4, out vec4 arg5){return sparseTexelGradFetchARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4, arg5); }
#if DIT_GL_ARB_sparse_texture2
int sparseTextureARB(sampler2D_u16 s, vec2 arg1, out vec4 arg2){return sparseTextureARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
int sparseTextureGatherARB(sampler2D_u16 s, vec2 arg1, out vec4 arg2){return sparseTextureGatherARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
int sparseTextureGatherARB(sampler2D_u16 s, vec2 arg1, out vec4 arg2, int arg3){return sparseTextureGatherARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
#endif
#if DIT_GL_AMD_texture_gather_bias_lod
int sparseTextureGatherLodAMD(sampler2D_u16 s, vec2 arg1, float arg2, out vec4 arg3){return sparseTextureGatherLodAMD(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
int sparseTextureGatherLodAMD(sampler2D_u16 s, vec2 arg1, float arg2, out vec4 arg3, int arg4){return sparseTextureGatherLodAMD(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
#endif
#if DIT_GL_ARB_sparse_texture2
int sparseTextureGradARB(sampler2D_u16 s, vec2 arg1, vec2 arg2, vec2 arg3, out vec4 arg4){return sparseTextureGradARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
int sparseTextureLodARB(sampler2D_u16 s, vec2 arg1, float arg2, out vec4 arg3){return sparseTextureLodARB(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
#endif
vec4 texelFetch(sampler2D_u16 s, ivec2 arg1, int arg2){return texelFetch(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec4 texelFetch(texture2D_u16 s, ivec2 arg1, int arg2){return texelFetch(dit_texture2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
uvec4 texelFetch(usamplerBuffer_u16 s, int arg1){return texelFetch(dit_usamplerBuffer[nonuniformEXT(uint(s.idx))], arg1); }
vec4 texelGradFetch(sampler2D_u16 s, ivec2 arg1, int arg2, vec2 arg3, vec2 arg4){return texelGradFetch(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
vec4 texelProjFetch(sampler2D_u16 s, vec4 arg1, int arg2){return texelProjFetch(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec4 texelProjFetch(sampler2D_u16 s, ivec3 arg1, int arg2){return texelProjFetch(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec4 texelProjGradFetch(sampler2D_u16 s, vec4 arg1, int arg2, vec2 arg3, vec2 arg4){return texelProjGradFetch(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
vec4 texelProjGradFetch(sampler2D_u16 s, ivec3 arg1, int arg2, vec2 arg3, vec2 arg4){return texelProjGradFetch(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
vec4 texture(sampler2D_u16 s, vec2 arg1){return texture(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1); }
#if DIT_GL_NV_shader_texture_footprint
bool textureFootprintClampNV(sampler2D_u16 s, vec2 arg1, float arg2, int arg3, bool arg4, out gl_TextureFootprint2DNV arg5){return textureFootprintClampNV(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4, arg5); }
bool textureFootprintClampNV(sampler2D_u16 s, vec2 arg1, float arg2, int arg3, bool arg4, out gl_TextureFootprint2DNV arg5, float arg6){return textureFootprintClampNV(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4, arg5, arg6); }
bool textureFootprintGradClampNV(sampler2D_u16 s, vec2 arg1, vec2 arg2, vec2 arg3, float arg4, int arg5, bool arg6, out gl_TextureFootprint2DNV arg7){return textureFootprintGradClampNV(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4, arg5, arg6, arg7); }
bool textureFootprintGradNV(sampler2D_u16 s, vec2 arg1, vec2 arg2, vec2 arg3, int arg4, bool arg5, out gl_TextureFootprint2DNV arg6){return textureFootprintGradNV(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4, arg5, arg6); }
bool textureFootprintLodNV(sampler2D_u16 s, vec2 arg1, float arg2, int arg3, bool arg4, out gl_TextureFootprint2DNV arg5){return textureFootprintLodNV(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4, arg5); }
bool textureFootprintNV(sampler2D_u16 s, vec2 arg1, int arg2, bool arg3, out gl_TextureFootprint2DNV arg4){return textureFootprintNV(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4); }
bool textureFootprintNV(sampler2D_u16 s, vec2 arg1, int arg2, bool arg3, out gl_TextureFootprint2DNV arg4, float arg5){return textureFootprintNV(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3, arg4, arg5); }
#endif
vec4 textureGather(sampler2D_u16 s, vec2 arg1){return textureGather(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1); }
#if DIT_GL_AMD_texture_gather_bias_lod
vec4 textureGatherLodAMD(sampler2D_u16 s, vec2 arg1, float arg2){return textureGatherLodAMD(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec4 textureGatherLodAMD(sampler2D_u16 s, vec2 arg1, float arg2, int arg3){return textureGatherLodAMD(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
#endif
vec4 textureGrad(sampler2D_u16 s, vec2 arg1, vec2 arg2, vec2 arg3){return textureGrad(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
vec4 textureLod(sampler2D_u16 s, vec2 arg1, float arg2){return textureLod(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec4 textureProj(sampler2D_u16 s, vec3 arg1){return textureProj(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1); }
vec4 textureProj(sampler2D_u16 s, vec4 arg1){return textureProj(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1); }
vec4 textureProjGrad(sampler2D_u16 s, vec3 arg1, vec2 arg2, vec2 arg3){return textureProjGrad(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
vec4 textureProjGrad(sampler2D_u16 s, vec4 arg1, vec2 arg2, vec2 arg3){return textureProjGrad(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2, arg3); }
vec4 textureProjLod(sampler2D_u16 s, vec3 arg1, float arg2){return textureProjLod(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
vec4 textureProjLod(sampler2D_u16 s, vec4 arg1, float arg2){return textureProjLod(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1, arg2); }
int textureQueryLevels(sampler2D_u16 s){return textureQueryLevels(dit_sampler2D[nonuniformEXT(uint(s.idx))]); }
int textureQueryLevels(texture2D_u16 s){return textureQueryLevels(dit_texture2D[nonuniformEXT(uint(s.idx))]); }
ivec2 textureSize(sampler2D_u16 s, int arg1){return textureSize(dit_sampler2D[nonuniformEXT(uint(s.idx))], arg1); }
ivec2 textureSize(texture2D_u16 s, int arg1){return textureSize(dit_texture2D[nonuniformEXT(uint(s.idx))], arg1); }
int textureSize(usamplerBuffer_u16 s){return textureSize(dit_usamplerBuffer[nonuniformEXT(uint(s.idx))]); }

