m=math
s=m.sin
c=m.cos
function TIC()t=time()/32
cls()
for i=0,200 do
if i<47 then
--poke(0x3fc0+i,4*((i+t/10)%3)*i/4)
end
j=(i/10+t)%120
i2=i/20
i2=i2*i2
z=j+i2
X=s(j)*z
Y=c(j)*z
circ(120+X,68+Y,z/10,1+j%12)
end
end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

