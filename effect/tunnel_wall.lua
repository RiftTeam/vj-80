--[[
TunnelWall = 6

function TunnelWall_DRAW(it,ifft)
  it=it/2
 for x=0,239 do
  for y=0,135 do
    sx=x-120*sin(it)
    sy=y-68 
    r=99+50*sin(it/3) - EControl*2
    s=sin(it)
    c=cos(it)
    X=(sx*s-sy*c)
    Y=(sy*s+sx*c)
    k=X%r-r/2
    l=Y%r-r/2
    a=math.atan2(k,l)
    e=(k*k+l*l)^.5  
    K=X//r 
    L=Y//r 
    ff = mm(abs(K+L)//1 + 10,0,255)
    ff = FFTH[ff]*.2+K
    pix(x,y,((99/e)*2*sin(it*ff+K+L)-a*2.55)%(8)+K+L*4)
  end
 end
end
--]]