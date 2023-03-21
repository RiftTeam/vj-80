cls(7)

osize=5
owidth=70

bt=0
bq=0
function TIC()t=time()/300
bb=fft(0)+fft(1)+fft(2)+fft(3)--+fft(4)

bm=0
for i=0,20 do
 bm=bm+fft(10+i)
end
bq=bq+0.01*bm
cx=120+50*math.sin(bq)
cy=68+35*math.sin(bq*0.7)

ta=64*(math.sin(t/10)+1)
tb=64*(math.sin(t/10+math.pi*2/3)+1)
tc=64*(math.sin(t/10+math.pi*4/3)+1)

for i=0,7 do
 poke(0x3fc0+i*3,(i/7*(ta)) )
 poke(0x3fc0+i*3+1,(i/7*(tb)) )
 poke(0x3fc0+i*3+2,(i/7*(tc)) )
end
for i=8,15 do
 poke(0x3fc0+i*3,math.min(255,(15-i)/7*ta + (i-8)/7*255) )
 poke(0x3fc0+i*3+1,math.min(255,(15-i)/7*tb + (i-8)/7*255) )
 poke(0x3fc0+i*3+2,math.min(255,(15-i)/7*tc + (i-8)/7*255) )
end

size=osize+20*(fft(0)+fft(1)+fft(2)+fft(3)+fft(4))
--circ(120,68,size-4,0)

bt=bt + .5*bb

for i=0,127 do
 ft=fft(i*2+1)+fft(i*2+2)
 ft=ft*2000*(i/127 + 0.25)
 
 a=i/127*math.pi*2+bt
 
 x=(math.sin(7*a+t)*4*bb+size)*math.sin(a)
 y=(math.sin(7*a+t)*4*bb+size)*math.cos(a)
 
 --line(cx,cy,cx+x,cy+y,0)
 c=math.min(ft,15)
 if c>=1 then
  pix(cx+x,cy+y,c)
 end
end

zb=10000*bb

for i=0,zb do
 d=math.random()
 d=1-(d^1.5)
 d1=size+d*(owidth-bb*10)
 d2=1+d1+bb*10
 a=math.random()*math.pi*2
 x=d1*math.sin(a)
 y=d1*math.cos(a)
 line(cx+(d1)*math.sin(a),cy+(d1)*math.cos(a),cx+(d2)*math.sin(a),cy+(d2)*math.cos(a),pix(cx+x,cy+y))
end

bz = 100
if zb<5000 then bz = 500 end
if zb<1000 then bz = 2000 end
for i=0,500 do
 d=math.random()
 d=1-(d^1.5)
 d=d*(size//1+owidth*1.5)
 a=math.random()*math.pi*2
 x=cx+d*math.sin(a)
 y=cy+d*math.cos(a)
 pix(cx+(d+1)*math.sin(a),cy+(d+1)*math.cos(a),math.min(15,math.max(0,(pix(x,y)+pix(x+1,y+1)+pix(x+1,y-1)+pix(x-1,y+1)+pix(x-1,y-1))/4.8)))
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

