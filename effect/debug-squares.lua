return {
    id = 'debug-squares',
    boot = function()
    end,
    draw = function(control, params, t)
		local w,h,dw,dh=12,12,15,15
		for iy=0,8 do
			for ix=0,15 do
				local x0,y0=ix*dw,4+iy*dh
				rect(x0,y0,w,h,ix)
			end
		end
	end,
}
