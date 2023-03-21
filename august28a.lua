m=math
s=m.sin
c=m.cos
p=m.pi
cls()
function TIC()t=time()/999
for i=0,32640 do
x=i%240
y=i/240
C=pix(x,y)-1
pix(x,y,C>0 and C or 0)end
for i=0,99 do
j=i/9
x=10*s(p*j+t)y=10*c(p*j+t)z=10*s(p*j)X=x*s(t)-z*c(t)Z=x*c(t)+z*s(t)circ(120+X*Z,68+y*Z,Z,15)end
end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

