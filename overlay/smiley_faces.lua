-- was: overlay index = 3

local NumSmilyFaces = 30
local SmilyFaces_xysr = {}

return {
    id="smiley_faces",
    boot=function()
        for i=1,NumSmilyFaces do
            SmilyFaces_xysr[i]={rand(300),rand(200)-32,rand(20)+10,rand()*tau}
        end
        table.sort(SmilyFaces_xysr, function (a,b) return a[3]<b[3] end)
    end,
    draw=function(data)
        nsf = clamp(OControl,1,NumSmilyFaces)
        for i=1,nsf do
         local sm=SmilyFaces_xysr[i]
         x=(sm[1])%300 - 30
         y=(sm[2]+FFTC[i]*2*i^0.8)%200 - 32
         s=(sm[3])
         a=sin(FFTC[i]*2)-tau/4
       
         ds = s/20
         x1=9*sin(a)-7*cos(a)
         y1=9*cos(a)+7*sin(a)
         x2=-9*sin(a)-7*cos(a)
         y2=-9*cos(a)+7*sin(a)
         circ(x,y,s,(i%15)+1)
         circ(x+x1*ds,y+y1*ds,4*ds,0)
         circ(x+x2*ds,y+y2*ds,4*ds,0)
         l=15*ds
         for j=-l,l do
          circ(x+12*ds*sin(j/l+a+tau/4),y+10*ds*cos(j/l+a+tau/4),1,0)
         end
        end
    end,
}
