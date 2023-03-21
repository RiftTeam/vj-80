r=math.random
s=math.sin
c=math.cos
tau=math.pi*2

points={}
lines={}
columns={}
rd={}
np=20
nl=20
nc=3

fftl={}
ffth={}

function BOOT()
 for i=1,nl do
  local lp={}
  for j=1,np do
   lp[j]=5*r()
  end
  rd[i]=lp
 end
 
 for h=1,nc do
  fftl={}
  for i=0,nl do
   fftl[i]=0
  end
  ffth[h]=fftl
 end
 
end
lt=0
t=0
lft=0

function clamp(x,a,b)
 return math.max(a,math.min(b,x))
end

function TIC()t=time()
 vbank(0)
 cls()
 vbank(1)
 cls()
 for i=0,15 do
  poke(0x3fc0+3*i,clamp(i*16,0,255))
  poke(0x3fc0+3*i+1,clamp(i*16,0,255))
  poke(0x3fc0+3*i+2,clamp(i*8,0,255))
 end
 --[[
 for i=0,2000 do
  x=r()*240-120
  y=r()*136-68
  a=math.atan2(x,y)
  d=(x^2+y^2)^.5
  x=x+120
  y=y+68
  pix((d-2)*s(a)+120,(d-2)*c(a)+68,clamp(pix(x,y)-1,0,15))
  pix(x,y,0)
 end
 --]]

 fps=(1000/(t-lft))//1
 lft=t

 if (t-lt)>=40 then
  for h=1,nc do
   ffth[h][0]=0
   for i=nl,2,-1 do
    ffth[h][i]=ffth[h][i-1]
    ffth[h][0]=ffth[h][0]+ffth[h][i]
   end
   ffth[h][1]=10*fft(h*10)*h^2
   ffth[h][0]=ffth[h][0]+ffth[h][1]
   ffth[h][0]=ffth[h][0]/nl
  end
  lt=t
 end

 t=t/1000

 ccp={}
 for h=1,nc do
  local a = h/nc * tau
  ccp[h]={x=100*s(a+t/11), y=0, z=30*c(a+t/11), n=h}
 end
 table.sort(ccp, function (a,b) return a.z<b.z end)
 
 
 for h=1,nc do
  lines={}
  fftl=ffth[h]
  for i=1,nl do
   local lp={}
   for j=1,np do
    local a = j/np * tau
    local p={x=(20+rd[i][j]+fftl[i])*s(a+t)*s(i/nl*math.pi),
            y=(i-(nl/2))*4,
            z=(20+rd[i][j]+fftl[i])*c(a+t)*s(i/nl*math.pi)}
    a = t/4+h
    lp[j]={x=p.x*s(a)-p.y*c(a),
           y=p.y*s(a)+p.x*c(a),
           z=p.z}
    --lp[j]={x=p.x,
     --      y=p.y,
      --     z=p.z}
   end
   lines[i]=lp
  end
  columns[h]=lines
 end 

	local a = t
 for k=1,nc do
  if ccp[k].z >-23 then
   h=ccp[k].n
   for i=1,nl do
    vbank(1)
    for j=1,np-1 do
     sp=columns[h][i][j]
     ep=columns[h][i][j+1]
    
     if(sp.z+ep.z)>0 then
      sz=sp.z-100+ccp[k].z
      ez=ep.z-100+ccp[k].z
      sx=120+sp.x*99/sz+ccp[k].x
      sy=68+sp.y*99/sz+ccp[k].y
      ex=120+ep.x*99/ez+ccp[k].x
      ey=68+ep.y*99/ez+ccp[k].y
      line(sx,sy,ex,ey,ez/8)
     end
    --pix(120+sp.x*99/sz,68+sp.y*99/sz,12)
    end
    sp=columns[h][i][np]
    ep=columns[h][i][1]
    if(sp.z+ep.z)>0 then
      sz=sp.z-100+ccp[k].z
      ez=ep.z-100+ccp[k].z
      sx=120+sp.x*99/sz+ccp[k].x
      sy=68+sp.y*99/sz+ccp[k].y
      ex=120+ep.x*99/ez+ccp[k].x
      ey=68+ep.y*99/ez+ccp[k].y
     line(sx,sy,ex,ey,ez/8)
    end
 --  line(minx,miny,maxx,maxy,1)
   end
  end
 end


 if fps < 55 then 
  print("slow",0,0,15) 
 else
  rect(0,0,30,10,0)
 end
 vbank(0)
 circ(40,40,39,15)
 
 tt=t/4%4
 if tt < 1 then
  len=print("LOVE",-100,60,12,true,3)
  print("LOVE",42-len/2,22,12,true,3)
  len=print("BYTE",-100,60,12,true,3)
  print("BYTE",42-len/2,43,12,true,3)
 elseif tt < 2 then
  len=print("20",-100,60,12,true,4)
  print("20",42-len/2,18,12,true,4)
  len=print("23",-100,60,12,true,4)
  print("23",42-len/2,42,12,true,4)
 elseif tt < 3 then
  circb(40,40,6,0)
  circb(40,40,10,0)
  circb(40,40,30,0)
 else
  len=print("MT",-100,60,12,true,6)
  print("MT",43-len/2,25,12,true,6)
  
 end
 
 memcpy(0x4000,0,40*240)
 cls()
 
 
 focal=1+.5*ffth[1][0]
 
 size=80+40*ffth[1][0]
 hs=size/2
 for x=0,size do
  px=x-hs
  for y=0,size do
   py=y-hs//1
   
   a=math.atan2(px,py)
   d=(px^2+py^2)^.5
   
   focal=(d/hs)^(ffth[1][1])
   d=d*focal--*(t%1+.5)
   ix=d*s(a)+40
   iy=d*c(a)+40
   
   if d < hs then
    col=peek4(0x8000+ix+iy//1*240)
   else
    col = 0
   end
   
   ox=px+120
   oy=py+68
   if ox >0 and ox<240 and oy>0 and oy<136 then
    poke4(ox+oy*240,col)
   end
  end
 end
-- circ(120,68,10*ffth[3][0],15)
-- cls()
end

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

