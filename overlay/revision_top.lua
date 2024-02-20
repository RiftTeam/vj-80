-- was: overlay index = 12

return {
	id="revision_top",
	boot=function()
	end,
	draw=function(control, params, t) 
		--[[
		local rlp={}
		local ca = t * tau
		local bass = params.bass
		for x=-10,10 do
			for y=-10,10 do
				--dy=y*.8
				local d = (x^2+y^2)^.5 * (1+t%1/10)
				local a = atan2(x,y) + ca
				local s = (16-control)-2*d+bass*5--abs(x)-abs(y)
				local nx,ny = d * sin(a), d * cos(a)
				if s >= .5 then
					table.insert(rlp,{nx,ny,s})
				end
			end
		end

		for _,p in ipairs(rlp) do
			circ(120+9.5*p[1],68+8.5*p[2],p[3],8)
		end

		for _,p in ipairs(rlp) do
			circ(120+10*p[1],68+9*p[2],p[3],12)
		end 
		--]]
	end,
}
