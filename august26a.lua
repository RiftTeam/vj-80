m=math
r=m.random
p={}c=m.cos s=m.sin
for i=0,99 do
p[i]={x=4-8*r(),y=4-8*r(),z=20*r()}end
function TIC()t=time()/300
cls()for i=0,99 do
z=(p[i].z+t)%20x=p[i].x
y=p[i].y
t2=(1-z/9)X=x*c(t2)-y*s(t2)Y=y*c(t2)+x*s(t2)circ(120+X*z,68+Y*z,20-z,5-(z/5))end
end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

