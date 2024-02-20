function clamp(x,a,b)
	return max(a,min(b,x))
end

function smoothStep(x,e1,e2)
	local y=clamp(x,e1,e2)
	local st=(y-e1)/(e2-e1)
	return st*st*(3-2*st)
end