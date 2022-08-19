----------------- FiveM RealWorld MAC
----------------- https://www.realw.kr

--[[
  ** RWAPIObfuscate Class (Inheritance RWAPIBase Class)
]]
RWAPIObfuscate = rw_class(RWAPIBase)

function RWAPIObfuscate:__init(config)
  self:SetConfig(config)
  print("Load Module: RWAPIObfuscate")
end

function RWAPIObfuscate:New(fileName, script, options, callback)
  local reqUrl = string.format("%s%s/new", self.config.apiNode, self.config.apiUrls.obfuscate)
  local reqData = {
    ["fileName"] = fileName,
    ["script"] = script,
    ["options"] = options or {}
  }
  local reqHeaders = self.config.defaultRequestHeaders
  reqHeaders["X-API-Credential"] = self.config.apiKey

  self:HttpRequest(
    reqUrl,
    function(errorCode, resultData, resultHeaders)
      if type(callback) == "function" then
        resultData = json.decode(resultData)
        if not resultData then
          callback(false, nil, errorCode)
          return
        end
        callback(true, resultData, nil)
      end
    end,
    "POST",
    json.encode(reqData),
    reqHeaders
  )
end

function RWAPIObfuscate:Ob(fileName, script, options, callback)
  local reqUrl = string.format("%s%s/ob", self.config.apiNode, self.config.apiUrls.obfuscate)
  local reqData = {
    ["fileName"] = fileName,
    ["script"] = script,
    ["options"] = options or {}
  }
  local reqHeaders = self.config.defaultRequestHeaders
  reqHeaders["X-API-Credential"] = self.config.apiKey

  self:HttpRequest(
    reqUrl,
    function(errorCode, resultData, resultHeaders)
      if type(callback) == "function" then
        resultData = json.decode(resultData)
        if not resultData then
          callback(false, nil, errorCode)
          return
        end
        callback(true, resultData, nil)
      end
    end,
    "POST",
    json.encode(reqData),
    reqHeaders
  )
end

function RWAPIObfuscate:Status(id, callback)
  local reqUrl = string.format("%s%s/status/%s", self.config.apiNode, self.config.apiUrls.obfuscate, id)
  self:HttpRequest(
    reqUrl,
    function(errorCode, resultData, resultHeaders)
      if type(callback) == "function" then
        resultData = json.decode(resultData)
        if not resultData then
          callback(false, nil, errorCode)
          return
        end
        callback(true, resultData, nil)
      end
    end,
    "GET"
  )
end

function RWAPIObfuscate:Download(id, callback)
  local reqUrl = string.format("%s%s/download/%s?format=json", self.config.apiNode, self.config.apiUrls.obfuscate, id)
  self:HttpRequest(
    reqUrl,
    function(errorCode, resultData, resultHeaders)
      if type(callback) == "function" then
        resultData = json.decode(resultData)
        if not resultData then
          callback(false, nil, errorCode)
          return
        end
        callback(true, resultData, nil)
      end
    end,
    "GET"
  )
end

function RWAPIObfuscate:Obfuscate(fileName, script, options, callback)
  self:Ob(
    fileName,
    script,
    options,
    function(success, data, errorCode)
      if not success or not data then
        if type(callback) == "function" then
          callback(false, nil, errorCode)
        end
        return
      end
      if type(callback) == "function" then
        callback(true, base64.decode(data.data))
      end
    end
  )
end

function RWAPIObfuscate:ObfuscateFromFile(fileName, srcPath, distPath, options, callback)
  local srcPathObj = self:SplitPath(srcPath)
  local distPathObj = self:SplitPath(distPath)
  local fileContent = LoadResourceFile(srcPathObj.resName, srcPathObj.fileName)
  local script = ""
  if fileContent then
    script = base64.encode(fileContent)
  end
  self:Obfuscate(
    fileName,
    script,
    options,
    function(success, data, errorCode)
      if success and data then
        SaveResourceFile(distPathObj.resName, distPathObj.fileName, data, -1)
      end
      callback(success, data, errorCode)
    end
  )
end

function RWAPIObfuscate:ObfuscateAsync(fileName, script, options)
  local p = promise.new()
  self:Obfuscate(
    fileName,
    script,
    options,
    function(...)
      p:resolve(table.pack(...))
    end
  )
  return table.unpack(Citizen.Await(p))
end

function RWAPIObfuscate:ObfuscateFromFileAsync(fileName, srcPath, distPath, options)
  local p = promise.new()
  self:ObfuscateFromFile(
    fileName,
    srcPath,
    distPath,
    options,
    function(...)
      p:resolve(table.pack(...))
    end
  )
  return table.unpack(Citizen.Await(p))
end
