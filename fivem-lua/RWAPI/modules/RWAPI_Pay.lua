----------------- FiveM RealWorld MAC
----------------- https://www.realw.kr

--[[
  ** RWAPIPay Class (Inheritance RWAPIBase Class)
]]
RWAPIPay = rw_class(RWAPIBase)

function RWAPIPay:__init(config)
  self:SetConfig(config)
  print("Load Module: RWAPIPay")
end
