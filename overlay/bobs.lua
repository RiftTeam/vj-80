-- was: overlay index = 8

return {
	id="bobs",
	boot=function()
	end,
	draw=function(control, params, t)
		local mid=params.mid
		for i=0,99 do
			local j=i/12
			local x=10*sin(pi*j+t)
			local y=10*cos(pi*j+t)
			local z=10*sin(pi*j)
			local X=x*sin(t)-z*cos(t)
			local Z=x*cos(t)+z*sin(t)
			circ(120+X*Z,68+y*Z,Z,control*mid)
		end
	end,
}
