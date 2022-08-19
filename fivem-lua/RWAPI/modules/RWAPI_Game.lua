----------------- FiveM RealWorld MAC
----------------- https://www.realw.kr

--[[
  ** RWAPIGame Class (Inheritance RWAPIBase Class)
]]
RWAPIGame = rw_class(RWAPIBase)

function RWAPIGame:__init(config)
  self:SetConfig(config)
  print("Load Module: RWAPIGame")
end
