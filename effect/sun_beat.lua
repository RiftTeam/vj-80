SunBeat = 2
SunBeatPAL = {}

function SunBeat_BOOT()
 for i=0,15 do
  SunBeatPAL[i*3]=mm(i*32,0,255)
  SunBeatPAL[i*3+1]=mm(i*24-128,0,255)
  SunBeatPAL[i*3+2]=mm(i*24-256,0,255)
 end
end

function SunBeat_BDR(l)
 --if l~=0 then return end
 PAL_Switch(SunBeatPAL,0.05)
end

function SunBeat_DRAW(it,ifft)
 if(it%1>=0.95) then
  for y=0,136 do 
   for x=0,240 do
    pix(x,y,((math.pi*math.atan(x-120,y-68))+t)%4+1)
   end 
  end 
  circ(120,68,50+5*math.sin(t/150),15)
 end
end
