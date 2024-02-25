-- was: overlay index = 4
local TImages={}
local TWfirst = true
local TIimageID = 1

return function(screenFns)
	return {
		id='warp',
		boot=function()
			for _,screenFn in ipairs(screenFns) do
				cls()
				screenFn()
				table.insert(TImages, screenToPoints())
			end
			cls()
		end,
		draw=function(control, params, t)
			local bassM,midM,highM = params.bass / 400,params.mid / 100,params.high/100
			local rotScale = 1/400
	--		local it=sin(t/4*tau)^2
			local scale=(.5+sin(t/4*tau))/control
			local rot=sin(t/4*tau)
			local TWp = TImages[clamp(TIimageID,1,#TImages)]
			for i=1,#TWp do
				local pp=TWp[i]
				local b=pp.a + 2*pi*sin(rot * pp.d * rotScale + midM)
	--			local w=pp.d/2+10*sin(pp.d/40*bass)+(it/control)*pp.d+high
	--			local w=pp.d/2+10*sin(pp.d/bassM)+(it/control)*pp.d+highM
				local w=pp.d/2+10*sin(pp.d * bassM) + scale * pp.d + highM
				local nx,ny=120+w*sin(b),68+w*cos(b)
				pix(nx,ny,pp.c)
			end
		end,
	}
	end
