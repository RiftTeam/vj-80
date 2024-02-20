-- was: effect index = 13
local FC_osize=20

return {
	id='fft_circ',
	boot=function()
	end,

	draw=function(control, params, t)
		local size=FC_osize+params.bass*2 + control
		local ffth=params.ffth

		for r=0,255 do
			local a=(r/255+r)*tau
			local k=r//3
			local c=((ffth[(k-1)%256]+ffth[(k+1)%256])/2+ffth[k])*600*((k/255)*1.5+.015)
			local x,y=(size)*sin(a),(size)*cos(a)
			local x1,y1=(size+c/4*control)*sin(a), (size+c/4*control)*cos(a)
			--pix(120+x,68+y,1+c)
			line(120+x,68+y,120+x1,68+y1,1+min(14,c))
		end
	end,
}
