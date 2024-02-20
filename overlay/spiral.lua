-- was: overlay index = 7

return {
	id="spiral",
	boot=function()
	end,
	draw=function(control, params, t)
		local tt=t*30
		for i=0,200 do
			local j=(i/10+tt)%120
			local i2=i/20
			i2=i2*i2
			local z=j+i2
			local X,Y=sin(j)*z,cos(j)*z
			circ(120+X,68+Y,z/10-control*2,clamp(15*j/120,0,15))
		end
	end,
}
