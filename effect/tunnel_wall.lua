-- was: effect index = 6
return {
	id='tunnel_wall',
	boot=function()
	end,

	draw=function(control, params, t)
		t=t/2
		local ffth=params.ffth
		for x=0,239 do
			for y=0,135 do
				local sx,sy=x-120*sin(t),y-68 
				local r=99+50*sin(t/3) - control*2
				local s,c=sin(t),cos(t)
				local X,Y=(sx*s-sy*c),(sy*s+sx*c)
				local k,l=X%r-r/2, Y%r-r/2
				local a=atan2(k,l)
				local e=(k*k+l*l)^.5  
				local K,L=X//r,Y//r 
				local ff = clamp(abs(K+L)//1 + 10,0,255) *.2 + K
				pix(x,y,((99/e)*2*sin(t*ff+K+L)-a*2.55)%(8)+K+L*4)
			end
		end
	end,
}
