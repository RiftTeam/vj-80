-- was: effect index = 18
return {
    id='worms',
    boot=function()
    end,

	draw=function(control, params, t)
        for p=0,14,.01 do
	        circ(
				120+sin(p+t/3)*(p*6-8+sin(t)*20),
				68+sin(p+t+1)*(p*3-8+sin(t)*10),
				abs(sin(p+t)*p*2.5),
				p*17%8
			)
        end
    end,
}
