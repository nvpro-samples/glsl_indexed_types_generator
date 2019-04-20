--[[
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
]]

return {
  -- descriptorsets are generated as layout(set = P_DSET_IDX + mapping)  
  P_DSET_IDX    = "DIT_DSET_IDX",
  
  -- extension usage is wrapped into: #if P_EXT..extension  
  P_EXT         = "DIT_",
  
  -- descriptorsets are generated as: uniform TYPE P_TABLE..TYPE[];
  P_TABLE       = "dit_",
  
  -- constructors are generated as:   P_CONSTRUCTOR..TYPE( ... )
  P_CONSTRUCTOR = "c_",
  
  -- all table accesses are made as: table[P_ACCESS(uint(idx))]
  P_ACCESS      = "nonuniformEXT",
  
  -- created by output using glslangValidator --dump-builtin-symbols
  symbolFile    = "vk_fragment.txt",
  -- optional check the results of the internal "simplifySymbols" 
  symbolFileOut = nil,
  outputFile    = "sampler_indexed_types.glsl",
  
  indexType     = "uint16_t",
  
  -- Define what types should be generated.
  -- The number is the set offset applied to P_DSET_IDX.
  -- Leave table nil and all samplers get exported to same dset

  output = {
    sampler2D         = 0,
    texture2D         = 1,
    usamplerBuffer    = 2,
  },
}