-- Was: modifier index = 5

local PMBsize = 20
return {
    id='pix_motion_blur',
    draw=function(amount, control, params, t)
        local size = PMBsize+(t)%5
        local limit = 50 + control
        for i=0,amount/4 do
            local d = 2+size+rand(limit)
            local a = rand()*tau
            local x,y = d*sin(a),d*cos(a)
            if x >= -119 and x <= 118 and y >=-67 and y <= 66 then
                pix(120+x,68+y,clamp(((pix(120+x,68+y)+pix(120+x-1,68+y-1)+pix(120+x+1,68+y-1)+pix(120+x-1,68+y+1)+pix(120+x+1,68+y+1))/4.8),0,15))
            end
        end

        for i=0,amount do
            local d=size+rand(limit)
            local a=rand()*tau
            local x,y=d*sin(a), d*cos(a)
            if x >= -120 and x <= 119 and y >=-68 and y <= 67 then
                pix(120+x,68+y,pix(120+(d-1)*sin(a),68+(d-1)*cos(a)))
            end
        end
    end,
}