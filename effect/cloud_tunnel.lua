-- was: effect index = 7
return {
	id='cloud_tunnel',
	boot=function()
	end,
	draw=function(control, params, t)
		local ifft=params.mid
		for i=0,32639 do
			local x,y=i%240-120,i//240-68
			local s,c=sin(t),cos(t)
			local k=(x*s-y*c)%40-20
			local l=(y*s+x*c)%40-20
			local d=(x*x+y*y)^.5
			local a=atan2(y,x)
			local e=(k*k+l*l)^.5
			local c=((99/d)*(e/30+s+ifft)-a*2.55)%8+control
			poke4(i,c)
		end
	end,
}
