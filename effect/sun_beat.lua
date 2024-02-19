-- was: effect index = 2

local SunBeatPAL = {}

return {
    id='sun_beat',
    boot=function()
        for i=0,15 do
            SunBeatPAL[i*3]=clamp(i*32,0,255)
            SunBeatPAL[i*3+1]=clamp(i*24-128,0,255)
            SunBeatPAL[i*3+2]=clamp(i*24-256,0,255)
        end
    end,
    draw=function(data)
        local it=data.et
        if(it%1>=0.95) then
         for y=0,136 do 
          for x=0,240 do
           pix(x,y,((math.pi*math.atan(x-120,y-68))+t)%4+1)
          end 
         end 
         circ(120,68,50+5*math.sin(t/150),15)
        end
    end,
    bdr=function(l)
        PAL_Switch(SunBeatPAL,0.05)
    end,
}
