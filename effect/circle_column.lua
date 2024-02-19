--[[
CircleColumn = 10

CC_p={}
CC_sz = 25

function CircleColumn_DRAW(it,ifft)
  it=it*tau
  CC_p={}
  for i=1,CC_sz^2 do
   y=i//(CC_sz/2)-CC_sz/2
   a=(i%CC_sz)/CC_sz*tau
   d=CC_sz+CC_sz/3*math.cos(y/5+it/4)+FFTH[mm(i/10+5,0,255)//1]*(i/255)*500-- ifft
   x=d*sin(a+it/7+sin(y/CC_sz))
   z=d*cos(a+it/7+sin(y/CC_sz))
   CC_p[i]={x=x,y=y,z=z}
  end
  table.sort(CC_p, function(a,b) return b.z > a.z end)
  for i=1,#CC_p do
   if CC_p[i].z > 15+EControl then
    circ(120+CC_p[i].x*CC_p[i].z/9+20*sin(CC_p[i].y/5),48+CC_p[i].y*CC_p[i].z/5,CC_p[i].z/5,mm(CC_p[i].z/2,0,15))
   end
  end
end
--]]