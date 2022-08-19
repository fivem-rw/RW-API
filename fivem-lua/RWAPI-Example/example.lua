local LoadTestFile = function(path)
  return LoadResourceFile(GetCurrentResourceName(), path)
end

local testFileSrcPath = "/files/test.lua"
local testFileDistPath = "/files/test.obfuscate.lua"
local testFileName = "test.lua"
local testScript = base64.encode(LoadTestFile(testFileSrcPath))

local Example1 = function()
  RWAPI.Obfuscate:Obfuscate(
    testFileName,
    testScript,
    {},
    function(success, data, errorCode)
      print(success, data, errorCode)
    end
  )
end

local Example2 = function()
  local srcPath = string.format("%s%s", GetCurrentResourceName(), testFileSrcPath)
  local distPath = string.format("%s%s", GetCurrentResourceName(), testFileDistPath)
  RWAPI.Obfuscate:ObfuscateFromFile(
    testFileName,
    srcPath,
    distPath,
    {},
    function(success, data, errorCode)
      print(success, data, errorCode)
    end
  )
end

local Example3 = function()
  local success,
    data,
    errorCode = RWAPI.Obfuscate:ObfuscateAsync(testFileName, testScript, {})
  print(success, data, errorCode)
end

local Example4 = function()
  local srcPath = string.format("%s%s", GetCurrentResourceName(), testFileSrcPath)
  local distPath = string.format("%s%s", GetCurrentResourceName(), testFileDistPath)
  local success,
    data,
    errorCode = RWAPI.Obfuscate:ObfuscateFromFileAsync(testFileName, srcPath, distPath, {})
  print(success, data, errorCode)
end

Citizen.CreateThread(
  function()
    --Example1()
    --Example2()
    --Example3()
    --Example4()
  end
)
