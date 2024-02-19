-- Was: modifier index = 5

local PMBsize = 20
return {
    id='pix_motion_blur',
    draw=function(data)
        local amount,mt,mc=data.amount,data.mt,data.mc

        local size=PMBsize+(mt)%5
        local limit=50 + mc
        for i=0,amount/4 do
            d=2+size+rand(limit)
            a=rand()*tau
            x=d*sin(a)
            y=d*cos(a)
            if x >= -119 and x <= 118 and y >=-67 and y <= 66 then
                pix(120+x,68+y,clamp(((pix(120+x,68+y)+pix(120+x-1,68+y-1)+pix(120+x+1,68+y-1)+pix(120+x-1,68+y+1)+pix(120+x+1,68+y+1))/4.8),0,15))
            end
        end

        for i=0,amount do
            d=size+rand(limit)
            a=rand()*tau
            x=d*sin(a)
            y=d*cos(a)
            if x >= -120 and x <= 119 and y >=-68 and y <= 67 then
                pix(120+x,68+y,pix(120+(d-1)*sin(a),68+(d-1)*cos(a)))
            end
        end
    end,
}