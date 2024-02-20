-- Was: modifier index = 7

return {
	id='rot_vert',
	draw=function(amount, control, params, t)
		local dir=1
		local lines = 0
		if control == 0 then
			lines = t%5//1
		else
			if control < 0  then
				dir = -1
			end
			--lines = abs(control)*(t%4+1)//1
			lines = (abs(control)*(t+1)//1)%136
		end

		if dir == 1 then
			-- going down
			memcpy(0x8000,(135-lines)*120,120*lines)
			for y=135-lines,0,-1 do
				memcpy((y+lines)*120,y*120,120)
			end
			memcpy(0,0x8000,120*lines)
		elseif dir == -1 then
			-- going up
			memcpy(0x8000,0,120*lines)
			for y=0,135-lines do
				memcpy(y*120,(y+lines)*120,120)
			end
			memcpy((136-lines)*120,0x8000,120*lines)
		end  
	end,
}
