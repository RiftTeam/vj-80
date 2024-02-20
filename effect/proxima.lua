-- was: effect index = 14

PR_p={}
PR_np=127
PR_tc=0

return {
	id='proxima',
	boot=function()
		for i=0,PR_np do
			PR_p[i]={x=rand(240.0),y=rand(136.0),sx=rand(10.0)-5,sy=rand(10.0)-5}
		end
	end,
	draw=function(control, params, t)
		local n = 255//PR_np

		local q={}
		for i=0,PR_np do
			local v=PR_p[i]
			v.x=(v.x+v.sx/5*sin(i/10+t)*t)%240
			v.y=(v.y+v.sy/8*sin(i/11+t)*t)%136
			q[i]=v
		end

		--table.sort(q, function (a,b) return a.x < b.x end)

		local ffth = params.ffth
		for i=0,PR_np do
			local v=q[i]
			local fi=ffth[i]*(.15+i/60) * control
			pix(v.x,v.y,fi*500)

			for j=i,PR_np do
				local w=q[j]
				local d=(v.x-w.x)^2 + (v.y-w.y)^2
				d=d^.5
				n=(i+j)/2
				local fj=ffth[j]*(.15+j/60) * control
				local ft = (fi + fj)

				if d < ft * 100 and i ~= j then
					line(v.x,v.y,w.x,w.y,ft*100)
					for l=j,PR_np do
						local z=q[l] -- q?  
						d=(v.x-z.x)^2 + (v.y-z.y)^2
						d=d^.5
						local fl = ffth[l]*(.15+l/60) * control
						local ft = fi + fj + fl
						if d < ft * 25 and l ~= j and l ~= i then
							tri(v.x,v.y,w.x,w.y,z.x,z.y,ft*100)
							goto continue
						end
					end
				end
			end
			::continue::
		end
	end,
}
