ffts={}
oldffts={}
ft={}
fi=0
for i=1,8 do
table.insert(ffts,{})
end
function TIC()t=time()//32
if t%4 == 0 then
ft={}
for j=0,255 do
table.insert(ft,fft(j))
end
oldffts=ffts
ffts={}
table.insert(ffts,ft)
for i=1,7 do
table.insert(ffts,oldffts[i])
end
end

cls(12)

rectb(46,4,146,110,0)

int=0
for i=1,#ffts do
ft=ffts[i]
if #ft > 0 then
 for j=1,127 do
  k=(ft[j*2]+ft[j*2+1])*(j/255 + .25)
  k=k*400
  int=(int + k)/2
  pix(54+j,8+i*12-int,15-i/4)
 end
end
end

print("TIC80 DIVISION",80,120)

end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

