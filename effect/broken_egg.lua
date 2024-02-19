-- was: effect index = 11
local BE_p={}
local BE_sz=25
local BE_depth=5

return {
      id='broken_egg',
      boot=function()
      end,
      draw=function(data)
            local it=data.et
            local ifft=data.bass
            BE_p={}
            it=it*tau*(EControl+.5)
            for i=1,BE_sz^2 do
                  y=i//(BE_sz/2)-BE_sz/2 + FFTH[clamp((i/10)%256,0,255)//1]*100*i/255
                  a=(i%BE_sz)/BE_sz*tau
                  d=BE_sz/2*sin(it/BE_depth)+BE_sz*sin(y/BE_sz)
                  x=d*sin(a+it/13)
                  z=d*cos(a+it/13)
                  a2=it/11
                  BE_p[i]={x=x*cos(a2)-y*sin(a2),y=y*cos(a2)+x*sin(a2),z=z}
            end
            for i=2,#BE_p do
                  line(120+BE_p[i].x*BE_p[i].z/9+20*sin(BE_p[i].y/5),
                  58+BE_p[i].y*BE_p[i].z/9,
                  120+BE_p[i-1].x*BE_p[i-1].z/9+20*sin(BE_p[i-1].y/5),
                  58+BE_p[i-1].y*BE_p[i-1].z/9,
                  clamp((abs(BE_p[i-1].z)+abs(BE_p[i].z))/2,0,15))
            end
      end,
}
