
function makePalette2(r1,g1,b1,r2,g2,b2)
	local pal={}
	for i=0,15 do
		pal[i*3]   = clamp(r1*abs(15-i)/15 + r2*abs(i)/15,0,255)
		pal[i*3+1] = clamp(g1*abs(15-i)/15 + g2*abs(i)/15,0,255)
		pal[i*3+2] = clamp(b1*abs(15-i)/15 + b2*abs(i)/15,0,255)
	end
	return pal
end

function makePalette3(r1,g1,b1,r2,g2,b2,r3,g3,b3)
	local pal={}
	for i=0,7 do
		pal[i*3]   = clamp(r1*abs(7-i)/7 + r2*abs(i)/7,0,255)
		pal[i*3+1] = clamp(g1*abs(7-i)/7 + g2*abs(i)/7,0,255)
		pal[i*3+2] = clamp(b1*abs(7-i)/7 + b2*abs(i)/7,0,255)
	end
	for i=1,8 do
		pal[21+i*3]   = clamp(r2*abs(8-i)/8 + r3*abs(i)/8,0,255)
		pal[21+i*3+1] = clamp(g2*abs(8-i)/8 + g3*abs(i)/8,0,255)
		pal[21+i*3+2] = clamp(b2*abs(8-i)/8 + b3*abs(i)/8,0,255)
	end
	return pal
end