-- Was: modifier index = 12

return {
    id = 'evilpaul_glitch',
    draw = function(amount, control, params, t)
        randseed(t//60)
        for i = 0, rand(0, 2) do
            local x1 = rand(0, 240)
            local x2 = rand(0, 240)
            local w = rand(5, 30)
            local m = rand(0, 1)
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
                        pix(x2 + x, y, rand(0, 1))
                    end
                end
            end
        end	
    end,
}