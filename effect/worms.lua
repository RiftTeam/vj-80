-- was: effect index = 18
return {
    id='worms',
    boot=function()
    end,
    draw=function(data)
        local et=data.et
        local abs,sin=math.abs,math.sin
        for p=0,14,.01 do
        circ(120+sin(p+et/3)*(p*6-8+sin(et)*20),
            68+sin(p+et+1)*(p*3-8+sin(et)*10),
            abs(sin(p+et)*p*2.5),
            p*17%8)
        end
    end,
}
