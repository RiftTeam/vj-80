-- Was: modifier index = 6

return {
	id='pix_jump_blur',
	draw=function(amount, control, params, t)
		local size = 10+t%5
		local limit = 100 + control
		local cx,cy=120, 68
		local tt = params.bass%1
		for i=0,tt*50 do
			local d=rand()
			d=1-(d^1.5)
			local d1=size+d*(limit-tt*10)
			local d2=1+d1+tt*10
			local a=rand()*tau
			local x,y=d1*sin(a),d1*cos(a)
			line(cx+(d1)*sin(a),cy+(d1)*cos(a),cx+(d2)*sin(a),cy+(d2)*cos(a),pix(cx+x,cy+y))
		end

		amount = min(amount,500)
		for i=0,amount do
			local d=rand()
			d=1-(d^1.5)
			d=d*(size//1+limit*1.5)
			local a=rand()*tau
			local x,y=cx+d*sin(a),cy+d*cos(a)
			if x >= 1 and x <= 239 and y >=1 and y <= 134 then
				pix(cx+(d+1)*sin(a),cy+(d+1)*cos(a),clamp((pix(x,y)+pix(x+1,y+1)+pix(x+1,y-1)+pix(x-1,y+1)+pix(x-1,y-1))/4.8,0,15))
			end
		end
	end,
}