--[[
Bitnick = 17

function Bitnick_DRAW(it,ifft)
   math.randomseed(2)
   local tt=(t/OControl)
   for x=0,51 do
				local w=math.random()*70+30
				local h=math.random()*20+10
				local posx=(math.random()*240+(tt/w*4)*x/20)%(240+w+x)-w
				local posy=math.random()*(136+h)-h
				local col=math.random()*2+math.cos(tt/2000)*2+5
				
				clip(posx,posy,w,h)
				for i=posx,posx+w do
						circ(i,posy+i//1%h,w/(col+16),col+i/300)
				end
				clip()
			end
end

--]]