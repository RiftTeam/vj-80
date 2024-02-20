-- was: effect index = 12
local PF_depth = 3
local PF_t=0


return {
	id='para_flower',
	boot=function()
	end,
	draw=function(control, params, t)
		local ifft=params.bass
		PF_t=PF_t+1
		for y=0+(PF_t%4)//1,135,4 do 
			for x=0,239 do
				dx,dy=x-120,y-68
				a=atan2(dx,dy)
				d=sqrt(dx^2+dy^2)
				pix(x,y,8+8*sin((5*ifft)*sin((PF_depth+control)*a+t*tau)+d/10+t))
			end
		end
	end,
}
