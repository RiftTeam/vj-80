-- Was: modifier index = 13

return {
    id='line_scratch',
    draw=function(data)
		local amount,mt,mc=data.amount,data.mt,data.mc

		for a=0,46 do
			local x=math.random(240)
			local y=math.random(136)
			local w=math.random(20)
			line(x,y,x+w,y,pix(x,y))
			line(x,y+1,x+w/2,y+1,pix(x,y))
		end
	end,
}