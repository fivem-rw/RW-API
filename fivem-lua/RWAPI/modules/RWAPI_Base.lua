----------------- FiveM RealWorld MAC
----------------- https://www.realw.kr

--[[
  ** RWAPI Base Class
]]
RWAPIBase = rw_class()

function RWAPIBase:__init()
  self.config = {}
  print("Load Module: RWAPIBase")
end

function RWAPIBase:GetConfig()
  return self.config
end

function RWAPIBase:SetConfig(args)
  if not self.config then
    self.config = {}
    self.config.apiNode = ""
    self.config.apiUrls = {}
    self.config.apiKey = ""
    self.config.defaultRequestHeaders = {}
  end
  if args.apiNode then
    self.config.apiNode = args.apiNode
  end
  if args.apiUrls then
    self.config.apiUrls = args.apiUrls
  end
  if args.apiKey then
    self.config.apiKey = args.apiKey
  end
  if args.defaultRequestHeaders then
    self.config.defaultRequestHeaders = args.defaultRequestHeaders
  end
end

function RWAPIBase:SplitPath(path)
  local charFirstPos = path:find("/")
  local pathObj = {}
  pathObj.resName = path:sub(1, charFirstPos - 1)
  pathObj.fileName = path:sub(charFirstPos, path:len())
  return pathObj
end

function RWAPIBase:HttpRequest(url, callback, method, data, headers)
  PerformHttpRequest(url, callback, method, data, headers)
end
