-- was: overlay index = 10

return {
    id="line_cut",
    boot=function()
    end,
	draw=function(control, params, t)
        local s=10+control
        local x=(t*s*2)%s*4
        for sx=-136,240+s+136,s*4 do
            for y=0,136+s,s do
                local cx=sx-y+x
                tri(cx,y-s,cx-s,y,cx,y+s,1)
                tri(cx,y-s,cx+s,y,cx,y+s,1)
            end
        end
    end,
}
