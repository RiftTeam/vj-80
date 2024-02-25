-- Was: modifier index = 13

return {
    id='line_scratch',
    draw=function(amount, control, params, t)
		for a=0,46 do
			local x=rand(240)
			local y=rand(136)
			local w=rand(20)
			line(x,y,x+w,y,pix(x,y))
			line(x,y+1,x+w/2,y+1,pix(x,y))
		end
	end,
}