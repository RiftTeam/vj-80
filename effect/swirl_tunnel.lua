-- was: effect index = 8
return {
	id='swirl_tunnel',
	boot=function()
	end,
	draw=function(data)
		local it,ifft=data.et,data.bass
		it=it/10
		k=sin(it*tau)*99
		l=sin(it*tau*2)*49
		for i=0,32639 do
			x=i%240-k-120
			y=i/240-l-68
			u=m.atan2(y,x)
			d=(x*x+y*y)^.5
			v=99/d
			 c=sin(v+(u+sin(v)*sin(ifft/4)*tau)+t/1000)+1
			poke4(i,clamp(c*8-c*((138-d)/138),0,15))
		end
	end,
}
