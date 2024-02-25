-- was: overlay index = 11

local TImages={}
local TWfirst = true
local TIimageID = 1

return function(screenFns)
	return {
		id="sticker_lens",
		boot=function()
			for _,screenFn in ipairs(screenFns) do
				cls()
				screenFn()
				table.insert(TImages, screenToPoints())
			end
			cls()
		end,
		draw=function(control, params, t)
			local bass = params.bass
			local ffth = params.ffth

			-- draw point data to spritesheet
			-- first blank
			--memset(0x4000,0,120*136)

			local size=100+40*bass
			local hs=size/2

			local TWp = TImages[clamp(TIimageID,1,#TImages)]
			for i=1,#TWp do
				p=TWp[i]

				local x=(p.x-120)/control
				local y=(p.y-68)/control
				local c=clamp(ffth[p.d//1]*50*(.05 + p.d/10)+t,0,15)
				local a=p.a
				local d=p.d/control

				local b=bass/5
				--local focal=(d/(hs*t%2))^(b)
				local focal=1+sin(d/20+t/20)*(b+t%1/2)
				d=d*focal--*(t%1+.5)

				local ix,iy=d*sin(a),d*cos(a)
				if d < size then
					local ox,oy=ix+120,iy+68
					if ox >=0 and ox<240 and oy>=0 and oy<136 then -- #TODO: unnecessary check?
						pix(ox,oy,c)
					end
				end
			end
		end,
	}
end