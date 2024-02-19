-- Was: modifier index = 3

return {
    id='grid_dim',
    draw=function(data)
        local amount,mt,mc=data.amount,data.mt,data.mc

        i=0
        for y=-1,36 do
            for x=-1,60 do
                i=i+1
                --if i > amount*5 then return end
                sx=x*4+(mt*20)%4
                sy=y*4+(mt*5)%4
                pix(sx,sy,clamp(pix(sx,sy)-mc,0,15))
            end
        end
    end,
}