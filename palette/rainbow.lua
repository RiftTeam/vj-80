local palette = {}

-- h: 0-1, s: 0-1, v: 0-1
function hsvToRgb(h, s, v)
	local i =  floor(h * 6)
	local f = h * 6 - i
	local c1 = v * (1 - s)
	local c2 = v * (1 - f * s)
	local c3 = v * (1 - (1 - f) * s)
  
	local r, g, b
  	local seg = i % 6
	if seg == 0 then r, g, b = v, c3, c1
	elseif seg == 1 then r, g, b = c2, v, c1
	elseif seg == 2 then r, g, b = c1, v, c3
	elseif seg == 3 then r, g, b = c1, c2, v
	elseif seg == 4 then r, g, b = c3, c1, v
	elseif seg == 5 then r, g, b = v, c1, c2
	end
  
	return r * 255, g * 255, b * 255
  end
--]]
return {
	id="rainbow",
	boot=function()
		palette[0],palette[1],palette[2]=0,0,0
		for i=0,14 do
			local c=i+1
			local r,g,b=hsvToRgb(i/15,1,1,1)
			palette[c*3],palette[c*3+1],palette[c*3+2]=r,g,b
		end
	end,
	get=function(y, t)
		return palette
	end,
}