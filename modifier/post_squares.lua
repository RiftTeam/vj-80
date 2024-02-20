-- Was: modifier index = 11

local PSp={x=0,y=0,sx=10,sy=10,t=0.02,lt=0}

return {
	id='post_squares',
	draw=function(amount, control, params, t)
		if abs(t-PSp.lt) >= PSp.t then
			PSp.lt = t
			local grid = 240/PSp.sx
			PSp.x=(rand(grid//1)-1)*PSp.sx
			grid=136/PSp.sy
			PSp.y=(rand(grid//1)-1)*PSp.sy
		end

		for i=PSp.x,PSp.x+PSp.sx do
			for j=PSp.y,PSp.y+PSp.sy do
				pix(i,j,clamp(pix(i,j)-control,0,15))
			end
		end
	end,
}