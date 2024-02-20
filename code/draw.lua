function arc(x,y,w,r,ca,wa,col)
	for i=ca-wa/2,ca+wa/2,.1/r do
	local si,ci=sin(i),cos(i)
	line(x+r*si,y+r*ci,x+(r+w)*si,y+(r+w)*ci,col)
	end
end
  
function tangent(x,y,w,r,ca,l,col)
	local cx,cy=r*sin(ca),r*cos(ca)
	local wx,wy=(r+w)*sin(ca),(r+w)*cos(ca)
	local tx,ty=l*sin(ca-pi/2),l*cos(ca-pi/2)
	for i=-l,l,.5 do
		line(x+cx+tx*i/l,y+cy+ty*i/l,x+wx+tx*i/l,y+wy+ty*i/l,col)
	end
end

function printlogo(x,y,kx,ky,col)
	for i=1,5 do
		local l=string.len(logo[i])
		for ch=1,l do
			print(string.sub(logo[i],ch,ch),x+(ch-1)*kx,y+(i-1)*ky,col+i,true,1,true)
		end
	end
end
