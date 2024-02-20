-- Was: modifier index = 3

return {
    id='grid_dim',
    draw=function(amount, control, params, t)
        local i=0
        for y=-1,36 do
            for x=-1,60 do
                i=i+1
                --if i > amount*5 then return end
                local sx, sy=x*4+(t*20)%4, y*4+(t*5)%4
                pix(sx,sy,clamp(pix(sx,sy)-control,0,15))
            end
        end
    end,
}