-- was: overlay index = 9

local JD_ffts={}
local JD_oldffts={}
local JD_ft={}
local JD_fi=0
local JD_ot=0

return {
	id="joy_division",
	boot=function()
		for i=1,8 do
			table.insert(JD_ffts,{})
		end
	end,

	draw=function(control, params, t)
		local ffth=params.ffth
		if control~=0 and JD_ot%control == 0 then
			JD_ft={}
			for j=0,255 do
				table.insert(JD_ft,ffth[j])
			end
			JD_oldffts=JD_ffts
			JD_ffts={}
			table.insert(JD_ffts,JD_ft)

			for i=1,7 do
				table.insert(JD_ffts,JD_oldffts[i])
			end
		end

		JD_ot = JD_ot + 1

		rectb(46,4,146,110,15)

		local int=0
		for i=1,#JD_ffts do
			JD_ft=JD_ffts[i]
			if #JD_ft > 0 then
				for j=1,127 do
					local k=(JD_ft[j*2]+JD_ft[j*2+1])*(j/255 + .05)
					k=k*400
					int=(int + k)/2
					pix(54+j,8+i*12-int,15-i/4)
				end
			end
		end

		print("Tic80 Division",54,116,15)
	end,
}
