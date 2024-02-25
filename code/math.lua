function clamp(x,a,b)
	return max(a,min(b,x))
end

function smoothStep(x,e1,e2)
	local y=clamp(x,e1,e2)
	local st=(y-e1)/(e2-e1)
	return st*st*(3-2*st)
end

function screenToPoints()
	local p={}
	for y=0,135 do 
		for x=0,239 do
			local c = pix(x,y)
			if c > 0 then
				local dx,dy = x-120,y-68
				local a=atan2(dx,dy)
				local d=(dx^2+dy^2)^.5

				table.insert(p,{x=x,y=y,a=a,d=d,c=c})
			end
		end
	end
	return p
end
