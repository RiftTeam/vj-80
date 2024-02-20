-- was: effect index = 8
return {
	id='swirl_tunnel',
	boot=function()
	end,
	draw=function(control, params, t)
		local ifft=params.bass
		t=t/10
		local k,l=sin(t*tau)*99, sin(t*tau*2)*49
		for i=0,32639 do
			local x,y=i%240-k-120,i/240-l-68
			local u=atan2(y,x)
			local d=(x*x+y*y)^.5
			local v=99/d
			local c=sin(v+(u+sin(v)*sin(ifft/4)*tau)+t/1000)+1
			poke4(i,clamp(c*8-c*((138-d)/138),0,15))
		end
	end,
}
