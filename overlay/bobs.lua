--[[
Bobs = 8
function Bobs_DRAW(it,ifft)
  for i=0,99 do
    local j=i/12
    local x=10*sin(pi*j+it)
    local y=10*cos(pi*j+it)
    local z=10*sin(pi*j)
    local X=x*sin(it)-z*cos(it)
    local Z=x*cos(it)+z*sin(it)
    circ(120+X*Z,68+y*Z,Z,OControl*MID)
  end
end
--]]