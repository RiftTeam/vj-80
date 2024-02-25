-- was: effect index = 5
return {
	id='quup',
	boot=function()
	end,
	draw=function(control, params, t)
		local tt=t/8 * control
		local P=3+tt//5%5
		local Q=P/2
		local I=tt/15%1
		for i=1,20 do
			for j=0,P-1,1 do
				local r=tt+pi*j/Q-i*sin(tt/50)
				local n=120+(i+I)*9*sin(r)
				local o=68+(i+I)*9*cos(r)
				r=tt+pi*(j+1)/Q-i*sin(tt/50)
				line(n,o,120+(i+I)*9*sin(r),68+(i+I)*9*cos(r),i+1)
				local l=i-1
				r=tt+pi*j/Q-l*sin(tt/50)
				if i>1 then 
					k=(l+I)*9 
				else 
					k=l*9 
				end
				line(n,o,120+k*sin(r),68+k*cos(r),i+1)
			end
		end
	end,
}
