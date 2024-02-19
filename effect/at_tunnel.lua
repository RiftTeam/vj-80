--[[
    ATTunnel = 4

function ATTunnel_BOOT()
end

function ATTunnel_DRAW(it,ifft)
 ta=ss((it*4)%4/4,0,1)
 for j=1,20 do
  n=3+j
  d=(4*j-it%64)
  if d~=0 then d=99/d end
  if d<120 and d >5 then 
   w=(ifft*2)*d/6
   chroma=.01*(1+sin(ta))
   cr=ss((it/4+2*j)%5,2,4)*tau+EControl*it/2
   if j%2 == 0 then
    for i=1,n do
     if (it/4%8 < 4) then
      arc(120,68,w,d,cr + tau/n*i +j/10,pi/n,12)
     else
      arc(120,68,1,d*(1-chroma),cr + tau/n*i +j/10,pi/n,2)
      arc(120,68,1,d+w,cr + tau/n*i +j/10,pi/n,10)
      arc(120,68,w,d,cr + tau/n*i +j/10,pi/n,12)
     end
    end
   else
    for i=1,n do
     if (it/4%6 < 3) then
      tangent(120,68,1,d-1,cr + tau/n*i +j/10,d,0)
      tangent(120,68,w,d,cr + tau/n*i +j/10,d,11+(j/2)%4)
     else
      tangent(120,68,1,d*(1-chroma),cr + tau/n*i +j/10,d,1)
      tangent(120,68,1,d*(1+chroma),cr + tau/n*i +j/10,d,9)
      tangent(120,68,w,d,cr + tau/n*i +j/10,d,11+(j/2)%4)
     end
    end
   end
  end
 end
end
--]]