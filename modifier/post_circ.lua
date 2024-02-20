-- Was: modifier index = 4

return {
	id='post_circ',
	draw=function(amount, control, params, t)
		t = t*40
		local lim = clamp(8 + control,0,15)
		for y=0,135 do 
			for x=0,239 do
				local dx,dy=120-x,68-y
				local d=sqrt(dx^2+dy^2)//1
				local a=atan2(dx,dy)
				if((10*sin(t/4+d/5))%100>50) then
					local c=pix(x,y)
					if c>lim then
						pix(x,y,clamp(c-8,0,15))
					end
				end 
			end 
		end
	end,
}