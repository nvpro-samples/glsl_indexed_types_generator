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

-- contact: Christoph Kubisch <ckubisch@nvidia.com>

-- configuration
-- system strings

-- you can provide a lua file via commandline as well
local args  = {...}
local sys   = dofile(args[1] or "config.lua")

-- if output is nil
-- actually output everything
if (sys.output == nil) then
  sys.output = {mt={}}
  sys.output.mt.__index = function(table, key)
    return 0
  end
  setmetatable(sys.output, sys.output.mt)
end

-------------------------------------------------------------------------------------------

local fnBlacklist = {
  -- capture strings are applied to function arguments
  
  -- These functions, or variants of functions require 
  -- compile-time constants, which overloading cannot
  -- cover. The list may no be exhaustive.
  
  textureGather = "%( [%w_]+, vec%d, int",
  textureGatherOffset = ".",
  textureGatherOffsets = ".",
  textureGatherLodOffsetAMD = ".",
  textureGatherLodOffsetsAMD = ".",
  
  textureOffset = ".",
  textureOffsetClampARB = ".",
  textureProjOffset = ".",
  textureGradOffset = ".",
  textureGradOffsetClampARB = ".",
  textureLodOffset = ".",
  textureProjGradOffset = ".",
  textureProjLodOffset = ".",  
  
  texelFetchOffset = ".",
  texelGradFetchOffset = ".",
  texelProjFetchOffset = ".",
  
  sparseTexelFetchOffsetARB = ".",
  sparseTexelGradFetchOffsetARB = ".",
  sparseTextureOffsetARB = ".",
  sparseTextureOffsetClampARB = ".",
  sparseTextureGradOffsetARB = ".",
  sparseTextureGradOffsetClampARB = ".",
  sparseTextureGatherOffsetARB = ".",
  sparseTextureGatherOffsetsARB = ".",
  sparseTextureGatherLodOffsetAMD = ".",
  sparseTextureGatherLodOffsetsAMD = ".",
  sparseTextureLodOffsetARB = ".",
}

-- basic to vector prefix
local basicToVector = {
  bool = "b",
  uint = "u",
  int = "i",
  float = "",
  double = "d",
  int8_t = "i8",
  int16_t = "i16",
  int32_t = "i32",
  int64_t = "i64",
  uint8_t = "u8",
  uint16_t = "u16",
  uint32_t = "u32",
  uint64_t = "u64",
  float16_t = "f16",
  float32_t = "f32",
  float64_t = "f64",
}

local basicToExtension = {
  int8_t = "GL_EXT_shader_explicit_arithmetic_types_int8",
  int16_t = "GL_EXT_shader_explicit_arithmetic_types_int16",
  int32_t = "GL_EXT_shader_explicit_arithmetic_types_int32",
  int64_t = "GL_EXT_shader_explicit_arithmetic_types_int64",
  uint8_t = "GL_EXT_shader_explicit_arithmetic_types_int8",
  uint16_t = "GL_EXT_shader_explicit_arithmetic_types_int16",
  uint32_t = "GL_EXT_shader_explicit_arithmetic_types_int32",
  uint64_t = "GL_EXT_shader_explicit_arithmetic_types_int64",
  float16_t = "GL_EXT_shader_explicit_arithmetic_types_float16",
  float32_t = "GL_EXT_shader_explicit_arithmetic_types_float32",
  float64_t = "GL_EXT_shader_explicit_arithmetic_types_float64",
}

local textureDims = {
  "1D",
  "1DArray",
  "2D",
  "2DArray",
  "2DRect",
  "3D",
  "Cube",
  "CubeArray",
  "Buffer",
  "2DMS",
  "2DMSArray",
}
local shadowDims = {
  "1D",
  "2D",
  "2DRect",
  "1DArray",
  "2DArray",
  "Cube",
  "CubeArray",
}

local samplerTypes = {}
local imageTypes = {}
local textureTypes = {}
for i,v in ipairs(textureDims) do
  table.insert(samplerTypes,  "sampler"..v)
  table.insert(textureTypes,  "texture"..v)
  table.insert(imageTypes,    "image"..v)
end
for i,v in ipairs(shadowDims) do
  table.insert(samplerTypes,  "sampler"..v.."Shadow")
end

local samplerConfig = {
  [""]    = {shadow = true},
  ["i"]   = {},
  ["u"]   = {},
  ["f16"] = {ext = "AMD_gpu_shader_half_float_fetch", shadow = true},
}

local function simplifySymbols(str)
  str = str:gsub(" +,", ",")
  str = str:gsub(" +", " ")
  str = str:gsub("in ", "")
  str = str:gsub("highp ", "")
  str = str:gsub("global ", "")
  str = str:gsub("coherent ","")
  str = str:gsub("writeonly ","")
  str = str:gsub("readonly ","")
  str = str:gsub("volatile ","")
  str = str:gsub("LEVEL (%d)\n", "")
  str = str:gsub("runtime-sized array of", "[]")
  str = str:gsub("unsized (%d)-element array of", "[%1]")
  str = str:gsub("(%d)-element array of", "[%1]")
  str = str:gsub("(%d)x(%d) matrix of ([%w_]+)",
    function(c,r, typ)
      return basicToVector[typ].."mat"..c..r
    end)
  str = str:gsub("(%d)-component vector of ([%w_]+)",
    function(components, typ)
      return basicToVector[typ].."vec"..components
    end)
  str = str:gsub("([%w_]+):%s+([%w_]+)%s+([%w_]+)(%b())",
    function(name, ret, func, args)
      assert(name == func)
      return ret.." "..func..args
    end)
  str = str:gsub("(%b[])([^,%)]+)([,%)])","%2%1%3")
  str = str:gsub("structure%b{} of ([%w_]+)", "%1")

  return str
end

local function parseSymbols(fname, fnameout)
  local f = io.open(fname, "rt")
  local str = f:read("*a")
  f:close()
  
  str = str:match("BuiltinSymbolTable (%b{})")
  str = str:sub(2,-2)
  str = simplifySymbols(str)
  
  if (fnameout) then
    local f = io.open(fnameout, "wt")
    f:write(str)
    f:close()
  end
  
  return str
end

local samplerToIndexType = {}
local samplerExtension = {}

local function genIndexDescriptorSets()
  local out = ""
  for prefix,cfg in pairs(samplerConfig) do
    local str = ""
    for _,t in ipairs({samplerTypes, textureTypes}) do
      for _,s in ipairs(t) do
        if (not cfg.shadow and s:match("Shadow")) then
        else
          local typ = prefix..s
          local out = sys.output[typ]
          if (out) then
            str = str.."layout(set="..sys.P_DSET_IDX.." + "..out..", binding=0) uniform "..typ.." "..sys.P_TABLE..typ.."[];\n"
          end
        end
      end
    end
    if cfg.ext and str ~= "" then
      out = out.."#if "..sys.P_EXT..cfg.ext.. "\n"
      out = out..str
      out = out.."#endif \n"
    else
      out = out..str
    end
  end
  return out
end

local function genIndexStructs()
  local out    = ""  
  local suffix = "_"..basicToVector[sys.indexType]
  
  for prefix,cfg in pairs(samplerConfig) do
    local str = ""
    for _,t in ipairs({samplerTypes, textureTypes}) do
      for _,s in ipairs(t) do
        if (not cfg.shadow and s:match("Shadow")) then
        else
          local typ = prefix..s
          if (sys.output[typ]) then
            str = str.."struct "..typ..suffix.."{ "..sys.indexType.." idx; };\n"
            
            samplerToIndexType[typ] = typ..suffix
            samplerExtension[typ] = cfg.ext and sys.P_EXT..cfg.ext or  ""
          end
        end
      end
    end
    if cfg.ext and str ~= "" then
      out = out.."#if "..sys.P_EXT..cfg.ext.. "\n"
      out = out..str
      out = out.."#endif \n"
    else
      out = out..str
    end
  end
  return out
end

local function genIndexConstructors()
  local out = ""
  for prefix,cfg in pairs(samplerConfig) do
    local str = ""
    for _,s in ipairs(textureDims) do
      local styp = prefix.."sampler"..s
      local ityp = samplerToIndexType[styp]
      if (sys.output[styp]) then
        str = str..("$S $C_$S($I s){ return $R_$S[$A(uint(s.idx))]; }\n"):gsub("$([%w_]+)",
            { S = styp, I = ityp, C_ = sys.P_CONSTRUCTOR, R_ = sys.P_TABLE, A = sys.P_ACCESS})
      end
    end
    for _,s in ipairs( cfg.shadow and shadowDims or {}) do
      local styp = prefix.."sampler"..s.."Shadow"
      local ityp = samplerToIndexType[styp]
      if (sys.output[styp]) then
        str = str..("$S $C_$S($I s){ return $R_$S[$A(uint(s.idx))]; }\n"):gsub("$([%w_]+)",
            { S = styp, I = ityp, C_ = sys.P_CONSTRUCTOR, R_ = sys.P_TABLE, A = sys.P_ACCESS})
      end
    end
    for _,s in ipairs(textureDims) do
      local styp = prefix.."sampler"..s
      local ttyp = prefix.."texture"..s
      local ityp = samplerToIndexType[ttyp]
      local out = sys.output[styp]
      if (sys.output[styp] and sys.output[ttyp]) then
        str = str..("$S $C_$S($I t, sampler s){ return $S($R_$T[$A(uint(t.idx))], s); }\n"):gsub("$([%w_]+)",
            { S = styp, I = ityp, T = ttyp, C_ = sys.P_CONSTRUCTOR, R_ = sys.P_TABLE, A = sys.P_ACCESS})
      end
    end
    for _,s in ipairs( cfg.shadow and shadowDims or {}) do
      local styp = prefix.."sampler"..s.."Shadow"
      local ttyp = prefix.."texture"..s
      local ityp = samplerToIndexType[ttyp]
      if (sys.output[styp] and sys.output[ttyp]) then
        str = str..("$S $C_$S($I t, sampler s){ return $S($R_$T[$A(uint(t.idx))], s); }\n"):gsub("$([%w_]+)",
            { S = styp, I = ityp, T = ttyp, C_ = sys.P_CONSTRUCTOR, R_ = sys.P_TABLE, A = sys.P_ACCESS})
      end
    end
    if cfg.ext and str ~= "" then
      out = out.."#if "..sys.P_EXT..cfg.ext.. "\n"
      out = out..str
      out = out.."#endif \n"
    else
      out = out..str
    end
  end
  return out
end

local function genIndexOverrides(prototypes)
  local str = ""
  local extactive = ""
  
  for ret, name, args, ext in prototypes:gmatch("([%w_]+) ([%w_]+)(%b())([^\n]*)\n") do
    -- FIXME could be more than one
    local ext = ext:match("<([%w_]+),") or ""
    local ext = ext ~= "" and sys.P_EXT..ext or ""
    -- find first argument
    local styp = args:match("%(%s*([%w_]+)")
    if ( styp and samplerToIndexType[styp] and sys.output[styp] and 
      (not(fnBlacklist[name] and args:match(fnBlacklist[name]))) ) 
    then
      local exttyp  = samplerExtension[styp]
      local extused = ext..(exttyp ~= "" and (ext ~= "" and " && " or "")..exttyp or "")
      if (extused ~= extactive) then
        str = str..(extactive ~= "" and "#endif\n" or "")
        str = str..(extused ~= "" and ("#if "..extused.."\n") or "")
        extactive = extused
      end
      
      local ityp = samplerToIndexType[styp]
      
      local inargs = ""
      local exec   = (ret ~= "void" and "return " or "")..name.."("
      local args = args:sub(2,-2)..","
      local n = 0
      for arg in args:gmatch("([^,]+),") do
        if (n == 0) then
          inargs = inargs..ityp.." s"
          exec   = exec..sys.P_TABLE..styp.."["..sys.P_ACCESS.."(uint(s.idx))]"
        else
          inargs = inargs..", "..arg.." arg"..n
          exec   = exec..", ".."arg"..n
        end
        n = n + 1
      end
      str = str..ret.." "..name.."("..inargs:gsub(" +", " ").."){"..exec.."); }\n"
    end
  end
  
  if (extactive ~= "") then
    str = str.."#endif\n"
  end
  
  return str
end

local function genIndexing(prototypes)
  local str = "// auto-generated file by glsl_indexed_types_generator.lua\n\n"
  str = str.."// resource descriptorsets\n"
  str = str..genIndexDescriptorSets().."\n"
  str = str.."// resource indexing structs\n"
  str = str..genIndexStructs().."\n"
  str = str.."// sampler constructors\n"
  str = str..genIndexConstructors().."\n"
  str = str.."// function overrides\n"
  str = str..genIndexOverrides(prototypes).."\n"
  return str
end

local function generateIncludeFile(symbolFile, outFile, outSymbolFile)
  local prototypes = parseSymbols(symbolFile, outSymbolFile)
  
  local str = genIndexing(prototypes)
  
  local f = io.open(outFile, "wt")
  f:write(str)
  f:close();
end

generateIncludeFile(sys.symbolFile, sys.outputFile, sys.symbolFileOut)
