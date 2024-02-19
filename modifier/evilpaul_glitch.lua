-- Was: modifier index = 12

return {
    id='evilpaul_glitch',
    draw=function(data)
        local amount,mt,mc=data.amount,data.mt,data.mc
        math.randomseed(t//60)
        for i = 0, math.random(0, 2) do
            local x1 = math.random(0, 240)
            local x2 = math.random(0, 240)
            local w = math.random(5, 30)
            local m = math.random(0, 1)
            if m == 0 then
                for x = 0, w do
                    for y = 0, 136 do
                        local c = pix(x1 + x, y)
                        pix(x2 + x, y, c)
                    end
                end
            elseif m == 1 then
                for y = 0, 136 do
                    local c = pix(x1, y)
                    for x = 0, w do
                        pix(x2 + x, y, c)
                    end
                end
            elseif m == 2 then
                for y = 0, 136 do
                    for x = 0, w do
                        pix(x2 + x, y, math.random(0, 1))
                    end
                end
            end
        end	
    end,
}