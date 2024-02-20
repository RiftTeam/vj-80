-- was: effect index = 4
return {
	id='at_tunnel',
	boot=function()
	end,
	draw=function(control, params, t)
		local ta=smoothStep((t*4)%4/4,0,1)
		for j=1,20 do
			local n=3+j
			local d=(4*j-t%64)
			if d~=0 then
				d=99/d
			end

			if d<120 and d >5 then 
				local w=(params.mid*2)*d/6
				local chroma=.01*(1+sin(ta))
				local cr=smoothStep((t/4+2*j)%5,2,4)*tau+control*t/2
				if j%2 == 0 then
					for i=1,n do
						if (t/4%8 < 4) then
							arc(120,68,w,d,cr + tau/n*i +j/10,pi/n,12)
						else
							arc(120,68,1,d*(1-chroma),cr + tau/n*i +j/10,pi/n,2)
							arc(120,68,1,d+w,cr + tau/n*i +j/10,pi/n,10)
							arc(120,68,w,d,cr + tau/n*i +j/10,pi/n,12)
						end
					end
				else
					for i=1,n do
						if (t/4%6 < 3) then
							tangent(120,68,1,d-1,cr + tau/n*i +j/10,d,0)
							tangent(120,68,w,d,cr + tau/n*i +j/10,d,11+(j/2)%4)
						else
							tangent(120,68,1,d*(1-chroma),cr + tau/n*i +j/10,d,1)
							tangent(120,68,1,d*(1+chroma),cr + tau/n*i +j/10,d,9)
							tangent(120,68,w,d,cr + tau/n*i +j/10,d,11+(j/2)%4)
						end
					end
				end
			end
		end
	end,
}
