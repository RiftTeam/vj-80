-- was: overlay index = 4
local TWp={}
local TWfirst = true

function ScreenToPoints()
	local p={}
	for y=0,135 do 
		for x=0,239 do
			if pix(x,y) == 12 then 
				if x < 80 then
					c = 6 
				elseif x < 160 then
					c = 12
				else
					c = 3
				end
				local d=((x-120)^2+(y-68)^2)^.5
				local a=atan2(x-120,y-68)
				local nx,ny=d*sin(a),d*cos(a)

				table.insert(p,{x,y,c,a,d})
			end
		end
	end
	return p
end

return {
	id='text_warp',
	boot=function()
		cls()
		local l=flength("GOTO80",3,4)
		fprint("GOTO80",120-l/2,38,3,1,12,4)
		TWp = ScreenToPoints()
		table.insert(TImages,TWp)

		cls()
		l=flength("LOVEBYTE",3,2)
		fprint("LOVEBYTE",120-l/2,35,3,1,12,2)
		l=flength("2024",3,2)
		fprint("2024",120-l/2,70,3,1,12,2)
		TWp = ScreenToPoints()
		table.insert(TImages,TWp)
	end,
	draw=function(control, params, t)
		local bass,mid,high = params.bass,params.mid,params.high
		local it=sin(t/4*tau)^2
		TWp = TImages[clamp(TIimageID,1,#TImages)]
		for i=1,#TWp do
			local pp=TWp[i]
			local b=pp[4]+2*pi*sin(it*pp[5]/100+mid)
			local w=pp[5]/2+10*sin(pp[5]/40*bass)+(it/control)*pp[5]+high
			local nx,ny=w*sin(b),w*cos(b)
			pix(120+nx,68+ny,15)
		end
	end,
}
