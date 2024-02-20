-- was: effect index = 10
local CC_p={}
local CC_sz = 25

return {
	id='circle_column',
	boot=function()
	end,
	draw=function(control, params, t)
		t=t*tau
		CC_p={}
		for i=1,CC_sz^2 do
			local y = i//(CC_sz/2)-CC_sz/2
			local a = (i%CC_sz)/CC_sz*tau
			local d = CC_sz+CC_sz/3*cos(y/5+t/4)+FFTH[clamp(i/10+5,0,255)//1]*(i/255)*500-- ifft
			local x,z = d*sin(a+t/7+sin(y/CC_sz)), d*cos(a+t/7+sin(y/CC_sz))
			CC_p[i]={x=x,y=y,z=z}
		end

		table.sort(CC_p, function(a,b) return b.z > a.z end)

		for i=1,#CC_p do
			if CC_p[i].z > 15+control then
				circ(120+CC_p[i].x*CC_p[i].z/9+20*sin(CC_p[i].y/5),48+CC_p[i].y*CC_p[i].z/5,CC_p[i].z/5,clamp(CC_p[i].z/2,0,15))
			end
		end
	end,
}
