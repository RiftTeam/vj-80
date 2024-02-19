--[[
    CloudTunnel = 7
function CloudTunnel_BOOT()
end

function CloudTunnel_DRAW(it,ifft)
 for i=0,32639 do
  x=i%240-120
  y=i//240-68
  s=sin(it)
  c=cos(it)
  k=(x*s-y*c)%40-20
  l=(y*s+x*c)%40-20
  d=(x*x+y*y)^.5
  a=math.atan2(y,x)
  e=(k*k+l*l)^.5
  c=((99/d)*(e/30+sin(it)+ ifft)-a*2.55 )%8+EControl
  poke4(i,c)
 end
end
--]]