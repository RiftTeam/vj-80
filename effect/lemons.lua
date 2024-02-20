-- Was effect index = 15

local LE_points={}
local LE_lines={}
local LE_columns={}
local LE_rd={}
local LE_np=15
local LE_nl=15
local LE_nc=5

return {
	id='lemons',
	boot = function()
		for i=1,LE_nl do
			local lp={}
			for j=1,LE_np do
				lp[j]=5*rand()
			end
			LE_rd[i]=lp
		end
	end,
	draw = function(control, params, t)
		local h=0
		local n=0

		local numlem = clamp(LE_nc+control,1,20)

		local ccp={}
		t=t*tau
		for h=1,numlem do
			local a = h/numlem * tau
			ccp[h]={x=100*sin(a+t/7), y=0, z=30*cos(a+t/7), n=h}
		end

		table.sort(ccp, function (a,b) return a.z<b.z end)

		for h=1,numlem do
			LE_lines={}
			local ffth=params.ffth
			for i=1,LE_nl do
				local lp={}
				for j=1,LE_np do
					local a = j/LE_np * tau
					local p = {
						x=(20+LE_rd[i][j]+ffth[i]*10)*sin(a+t)*sin(i/LE_nl*pi),
						y=(i-(LE_nl/2))*4,
						z=(20+LE_rd[i][j]+ffth[i]*10)*cos(a+t)*sin(i/LE_nl*pi)
					}
					a = t/4+h
					lp[j]={
						x=p.x*sin(a)-p.y*cos(a),
						y=p.y*sin(a)+p.x*cos(a),
						z=p.z
					}
				end
				LE_lines[i]=lp
			end
			LE_columns[h]=LE_lines
		end 

		for k=1,numlem do
			if ccp[k].z >-23 then
				local h=ccp[k].n
				for i=1,LE_nl do
					for j=1,LE_np-1 do
						local sp=LE_columns[h][i][j]
						local ep=LE_columns[h][i][j+1]

						if(sp.z+ep.z)>0 then
							local sz=sp.z-100+ccp[k].z
							local ez=ep.z-100+ccp[k].z
							local sx=120+sp.x*99/sz+ccp[k].x
							local sy=68+sp.y*99/sz+ccp[k].y
							local ex=120+ep.x*99/ez+ccp[k].x
							local ey=68+ep.y*99/ez+ccp[k].y
							line(sx,sy,ex,ey,ez/8)
						end
						--pix(120+sp.x*99/sz,68+sp.y*99/sz,12)
					end
				
					local sp=LE_columns[h][i][LE_np]
					local ep=LE_columns[h][i][1]

					if(sp.z+ep.z)>0 then
						local sz=sp.z-100+ccp[k].z
						local ez=ep.z-100+ccp[k].z
						local sx=120+sp.x*99/sz+ccp[k].x
						local sy=68+sp.y*99/sz+ccp[k].y
						local ex=120+ep.x*99/ez+ccp[k].x
						local ey=68+ep.y*99/ez+ccp[k].y
						line(sx,sy,ex,ey,ez/8)
					end
					--  line(minx,miny,maxx,maxy,1)
				end
			end
		end
	end,
}

