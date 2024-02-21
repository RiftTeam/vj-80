-- was: palette index 6

local palette = {}

return {
	id="dutch",
	boot=function()
	end,
	get=function(y, t)
		local it=t
		local grader=sin(it*1/7+y/150)+1
		local gradeg=sin(it*1/13+y/150)+1
		local gradeb=sin(it*1/11+y/150)+1
		local rgbs = {}
		for i=0,15 do
			rgbs[i*3]=clamp(i*16*(grader),0,255)
			rgbs[i*3+1]=clamp(i*16*(gradeg),0,255)
			rgbs[i*3+2]=clamp(i*16*(gradeb),0,255)
		end
		return rgbs
	end,
}


