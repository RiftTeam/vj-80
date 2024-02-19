--[[
RevisionTop = 12
function RevisionTop_DRAW(it,ifft)
 rlp={}
 ca = it * tau
 for x=-10,10 do
  for y=-10,10 do
   --dy=y*.8
   d = (x^2+y^2)^.5 * (1+it%1/10)
   a = m.atan2(x,y) + ca
   s = (16-OControl)-2*d+BASS*5--abs(x)-abs(y)
   nx= d * sin(a)
   ny= d * cos(a)
   if s >= .5 then
    table.insert(rlp,{nx,ny,s})
   end
  end
 end

 for i=1,#rlp do
  p=rlp[i]
  circ(120+9.5*p[1],68+8.5*p[2],p[3],8)
 end

 for i=1,#rlp do
  p=rlp[i]
  circ(120+10*p[1],68+9*p[2],p[3],12)
 end
end
--]]