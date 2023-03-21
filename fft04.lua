cls(15)
osize=20
circ(120,68,osize+1,0)
for i=0,15 do
poke(0x3fc0+i*3,math.min(255,20+i*32))
poke(0x3fc0+i*3+1,math.min(255,10+i*24))
poke(0x3fc0+i*3+2,i*17)

end
function TIC()tt=time()
--circ(120,68,size,0)--cls()
size=osize
for i=0,15 do
size=size+5*fft(i)
end
for t=0,255 do
a=t/255*math.pi*2+tt/2000
k=t/3
--c=((fft(k-1)+fft(k+1))/2+fft(k))*400
c=((fft(k-1)+fft(k+1))/2+fft(k))*600*((k/255)*.75+.25)
--c=((fft(k-1)+fft(k+1))/2+fft(k))*400*((255-k)/255)
x=(size)*math.sin(a)
y=(size)*math.cos(a)
pix(120+x,68+y,1+c)
end

for i=0,250 do
d=2+size+math.random(70)
a=math.random()*math.pi*2
x=d*math.sin(a)
y=d*math.cos(a)
pix(120+x,68+y,math.min(((pix(120+x,68+y)+pix(120+x-1,68+y-1)+pix(120+x+1,68+y-1)+pix(120+x-1,68+y+1)+pix(120+x+1,68+y+1))/4.35),15))
end

for i=0,1000 do
d=size+math.random(70)
a=math.random()*math.pi*2
x=d*math.sin(a)
y=d*math.cos(a)
pix(120+x,68+y,pix(120+(d-1)*math.sin(a),68+(d-1)*math.cos(a)))
end

if (tt/200)%40 < 5 then 
 print("mantratronic",88,120,0)
end

end

function OVR()
circ(120,68,(size+osize)/2+1,0)
end
-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

