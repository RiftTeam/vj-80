-- hello all! mt here
--                        ^
-- hf+gl to alia, kii, & tobach
r=math.random
s=math.sin
fto={}
for i=0,255 do
fto[i]=0
end

p={}
np=127
for i=0,np do
p[i]={x=r(240.0),y=r(136.0),sx=r(10.0)-5,sy=r(10.0)-5}
end

tc=0

function SCN(l)
 for i=0,15 do
  poke(0x3fc0+i*3, 255-15*i)
  poke(0x3fc0+i*3+1, math.max(0,math.min(255,255-8*i-l)))
  poke(0x3fc0+i*3+2, math.max(0,math.min(255,255-26*i)))
 end
end

t=0.0
function TIC()
t=t+1--fft(1)*5.0 -- nm
n = 255//np
cls()
for i=0,255 do
 ftoa = 0
 for j=0,n do
  ftoa=ftoa+fft(i/n+j)*(.25+i/60)/n
 end
 fto[i]=fto[i]*3/4+ftoa/4
end
q={}
for i=0,np do
 v=p[i]
 v.x=(v.x+v.sx/5*s(i/10+t/100))%240
 v.y=(v.y+v.sy/8*s(i/11+t/100))%136
 q[i]=v
end
--table.sort(q, function (a,b) return a.x < b.x end)
for i=0,np do
 v=q[i]
 pix(v.x,v.y,fto[i]*500)
 
 for j=i,np do
  w=p[j]
  d=(v.x-w.x)^2 + (v.y-w.y)^2
  d=d^.5
  ft = fto[i] + fto[j]
  if d < ft * 100 and i ~= j then
   line(v.x,v.y,w.x,w.y,ft*100)
   for l=j,np do
    z=p[l]   
    d=(v.x-z.x)^2 + (v.y-z.y)^2
    d=d^.5
    ft = fto[i] + fto[j] + fto[l]
    if d < ft * 50 and l ~= j and l ~= i then
     tri(v.x,v.y,w.x,w.y,z.x,z.y,ft*100)
     goto continue
    end
   end
  end
  
 end
 
 ::continue::
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

