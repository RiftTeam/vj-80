--[[
    SmokeCircles = 6
SC_p={}
SC_np = 99
function SmokeCircles_BOOT()
  for i=0,SC_np do
    SC_p[i]={x=4-8*rand(),y=4-8*rand(),z=20*rand()}
  end
end

function SmokeCircles_DRAW(it,ifft)
  local tt=it*5
  for i=0,SC_np do
    local z=(SC_p[i].z+tt)%20
    local x=SC_p[i].x
    local y=SC_p[i].y
    local t2=-(1-z/9)
    local X=x*cos(t2)-y*sin(t2)
    local Y=y*cos(t2)+x*sin(t2)
    circ(120+X*z,68+Y*z,20-z,15-(z/1.5))
  end
end
--]]