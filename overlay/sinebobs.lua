-- was: overlay index = 2

return {
    id="sinebobs",
    boot=function()
    end,
    draw=function(data)
		local it,ifft=data.ot,data.ot
		local tt=time()+it*1000
		for x=-9,9 do
		   for y=-5,5 do
			   circ(x*11+120, y*10+68,
				   3*sin(tt/400+x/2-y/3*sin(tt/300+y/10))+3,
				   13)
			   
			   circ(x*11+120, y*10+68,
				   3*sin(tt/400+x/2-y/3*sin(tt/300+y/10)),
				   12)
		   end
	   end
	end,
}
