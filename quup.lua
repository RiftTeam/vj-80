function TIC()t=time()/500
for i=0,47 do
poke(16320+i,(math.sin(t/8*math.sin(i//6)+(i%3)))*99)
end
cls()
P=3+t//5%5
Q=P/2
I=t/15%1
for i=1,20 do
for j=0,P-1,1 do
r=t+math.pi*j/Q-i*math.sin(t/50)
n=120+(i+I)*9*math.sin(r)
o=68+(i+I)*9*math.cos(r)
r=t+math.pi*(j+1)/Q-i*math.sin(t/50)
line(n,o,120+(i+I)*9*math.sin(r),68+(i+I)*9*math.cos(r),i+1)
l=i-1
r=t+math.pi*j/Q-l*math.sin(t/50)
if i>1 then k=(l+I)*9 else k=l*9 end
line(n,o,120+k*math.sin(r),68+k*math.cos(r),i+1)
end
end
print("qu up",76,60,9,0,3)
end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

