/*
 * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#version 460
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_GOOGLE_include_directive : require

#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_scalar_block_layout : enable

#extension GL_ARB_sparse_texture2 : enable
#extension GL_ARB_sparse_texture_clamp : enable
#extension GL_AMD_texture_gather_bias_lod : enable
#extension GL_AMD_shader_fragment_mask : enable
#extension GL_NV_shader_texture_footprint : enable
#extension GL_EXT_samplerless_texture_functions : enable  // texelFetch with *texture

#define DIT_DSET_IDX 4

#define DIT_GL_NV_shader_texture_footprint 1

#include "sampler_indexed_types.glsl"

layout(push_constant, scalar) uniform pushData {
  sampler2D_u16         samp2D;
  texture2D_u16         tex2D;
  usamplerBuffer_u16    usampBuffer;
};

layout(set=0, binding=0) uniform sampler testSampler;

void main() {
  vec4 a = texture(c_sampler2D(tex2D,testSampler), vec2(0.5));
  vec4 b = texture(samp2D, vec2(0.5));
  gl_TextureFootprint2DNV temp;
  bool t = textureFootprintNV(samp2D, vec2(0.5), 8, true, temp);
  uvec4 c = texelFetch(usampBuffer, 7); 
};