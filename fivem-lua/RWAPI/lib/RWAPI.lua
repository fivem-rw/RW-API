----------------- FiveM RealWorld MAC
----------------- https://www.realw.kr

--[[
  ** RWAPI Initialize
]]
RWAPI = {}
RWAPI.config = {}
RWAPI.resName = "RWAPI"
RWAPI.requiredFilesPath = {
  "vendors/rw_class.lua",
  "vendors/base64.lua",
  "modules/RWAPI_Base.lua",
  "modules/RWAPI_Game.lua",
  "modules/RWAPI_Obfuscate.lua",
  "modules/RWAPI_Pay.lua"
}

RWAPI.LoadFile = function(path)
  return LoadResourceFile(RWAPI.resName, path)
end

RWAPI.LoadRequiredFiles = function()
  for _, path in ipairs(RWAPI.requiredFilesPath) do
    load(RWAPI.LoadFile(path))()
  end
end

RWAPI.LoadConfig = function()
  local config = json.decode(RWAPI.LoadFile("config.json"))
  RWAPI.config = {}
  RWAPI.config.apiNode = config.apiNode
  RWAPI.config.apiUrls = config.apiUrls
  RWAPI.config.apiKey = config.apiKey
  RWAPI.config.defaultRequestHeaders = {
    ["Content-Type"] = "application/json"
  }
end

RWAPI.LoadRequiredFiles()
RWAPI.LoadConfig()

RWAPI.Game = RWAPIGame(RWAPI.config)
RWAPI.Obfuscate = RWAPIObfuscate(RWAPI.config)
RWAPI.Pay = RWAPIPay(RWAPI.config)
