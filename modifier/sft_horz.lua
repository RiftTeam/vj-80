-- Was: modifier index = 10

return {
	id='sft_horz',
	draw=function(amount, control, params, t)
		local dir=1
		local pixels = 0
		if control == 0 then
			pixels = t%5//1
		else
			if control < 0  then
				dir = -1
			end
			--pixels = abs((control*t)%120)
			--pixels = (abs(control)+(t*2))%120
			pixels = (abs(control)*(t+1)//1)%120
		end

		if dir ==1 then
			-- going right
			for y=0,135 do
				-- take the whole line
				memcpy(0x8000,y*120, 120)

				-- put it back in two sections
				memcpy(y*120+pixels,0x8000, 120-pixels)
				memset(y*120,0, pixels)
			end
		else
			-- going left
			for y=0,135 do
				-- take the whole line
				memcpy(0x8000,y*120, 120)

				-- put it back in two sections
				memset(y*120+(120-pixels),0, pixels)
				memcpy(y*120,0x8000+pixels, 120-pixels)
			end
		end
	end,
}