--[[
ParaFlower = 12

PF_depth = 3
PF_t=0
function ParaFlower_DRAW(it,ifft)
 PF_t=PF_t+1
 for y=0+(PF_t%4)//1,135,4 do 
  for x=0,239 do
   X=x-120
   Y=y-68
   a=math.atan(X,Y)
   d=math.sqrt(X^2+Y^2)
   pix(x,y,8+8*sin((5*ifft)*sin((PF_depth+EControl)*a+it*tau)+d/10+it))
  end
 end
end
--]]