-- was: effect index = 1

local TF_size=200
return {
    id='twist_fft',
    boot=function()
    end,

	draw=function(control, params, t)
        local it=t*10*control
		local ffth=params.ffth
		local bass=params.bass
        -- lets do the twist again
        for i=0,239 do
            local x=(i-it//1)%240
            local fhx = (ffth[(x-1)%240]+ffth[(x)%240]+ffth[(x+1)%240])/3*(.9+x/60)
            local a=sin(it/10)* x/80
        
            local d=TF_size*fhx+5+5*bass
        
            local cy = 68+10*bass*sin(i/110+ it/12)
        
            local y1=d*sin(a)
            local y2=d*sin(a + tau/4)
            local y3=d*sin(a + tau/2)
            local y4=d*sin(a + tau*3/4)
        
            d=d/4
        
            if y1 < y2 then
                line(i,cy+y1,i,cy+y2,clamp(d,0,15))
            end
            if y2 < y3 then
                line(i,cy+y2,i,cy+y3,clamp(d+1,0,15))
            end
            if y3 < y4 then
                line(i,cy+y3,i,cy+y4,clamp(d+2,0,15))
            end
            if y4 < y1 then
                line(i,cy+y4,i,cy+y1,clamp(d+3,0,15))
            end
        end
    end,
    bdr=function(l)
        local lm=68-abs(68-l)
        for i=0,47 do
            poke(16320+i,clamp(sin(i)^2*i*lm/5.5,0,255))
        end
    end,
}
