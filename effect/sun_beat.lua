-- was: effect index = 2

-- #TODO: Figure out palette integration!

return {
	id='sun_beat',
	boot=function()
	end,
	draw=function(control, params, t)
		if(t%1>=0.95) then
			for y=0,136 do 
				for x=0,240 do
					pix(x,y,((pi*atan2(x-120,y-68))+t)%4+1)
				end 
			end 
			circ(120,68,50+5*sin(t/150),15)
		end
	end,
}
