-- title:  mt's vj rig
-- author: mantratronic
-- desc:   collection of effects made for the monday night tic80 jams on twitch.tv/fieldfxdemo
-- script: lua


-- in
--[[
logo={"  `___//  __//_ __//___//_---//___;---//__;--\\\\__.",
"  /  //--Y     \\   _/   _/        Y       Y      |",
" /       |  // |   _/   _/   /    |   a   |   // |",
"/   //   |     |  |/|  |/|  // // |   /   |  //  |",
"\\--//____/-//-_/\\-/  \\-/ |-//_//_mtr-//--|/-//___|"}

if (beat/4%4 > 1) then ta = 0 else ta = s(pi*ta) end
 println(44-ta*24,58-ta*1.5,3+ta,3+ta,0+beat*2)

--]]
--[[
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
 --]]


X = 7
function X_BOOT()
end

function X_DRAW(it,ifft)
end

NumEffects=14
NumOverlays=10
NumModifiers=6
NumModes=8
NumPalettes=10

-- Utils

m=math
sin=m.sin cos=m.cos max=m.max min=m.min
abs=m.abs pi=m.pi tau=m.pi*2 rand=m.random

function mm(x,a,b)
 return max(a,min(b,x))
end

function ss(x,e1,e2)
 y=mm(x,e1,e2)
 st=(y-e1)/(e2-e1)
 return st*st*(3-2*st)
end

function arc(x,y,w,r,ca,wa,col)
 for i=ca-wa/2,ca+wa/2,.1/r do
  si=sin(i)
  ci=cos(i)
  line(x+r*si,y+r*ci,x+(r+w)*si,y+(r+w)*ci,col)
 end
end
  
function tangent(x,y,w,r,ca,l,col)
 cx=r*sin(ca)
 cy=r*cos(ca)
 wx=(r+w)*sin(ca)
 wy=(r+w)*cos(ca)
 tx=l*sin(ca-pi/2)
 ty=l*cos(ca-pi/2)
 for i=-l,l,.5 do
  line(x+cx+tx*i/l,y+cy+ty*i/l,x+wx+tx*i/l,y+wy+ty*i/l,col)
 end
end

function printlogo(x,y,kx,ky,col)
 for i=1,5 do
  l=string.len(logo[i])
  for ch=1,l do
   print(string.sub(logo[i],ch,ch),x+(ch-1)*kx,y+(i-1)*ky,col+i,true,1,true)
  end
 end
end
 
-- FFT setup

FFTH={}
FFTC={}
FFTH_length=10
BASS=0
BASSC=0
BASSDIV=10
MID=0
MIDC=0
HIGHDIV=50
HIGH=0
HIGHC=0

FFT_Mult=10

function FFT_BOOT()
 for i=0,255 do
  FFTH[i]=0
  FFTC[i]=0
 end
end

function FFT_FILL()
 for i=0,239 do
  f=fft(i)*Loudness
  FFTH[i]=f/FFTH_length + FFTH[i]*((FFTH_length-1)/FFTH_length)
  FFTC[i]=FFTC[i]+f
 end
 
 BASS = 0
 for i=0,BASSDIV do
  BASS = BASS + FFTH[i]
 end
 BASSC=BASSC+BASS

 MID=0
 for i=BASSDIV+1,HIGHDIV do
  MID = MID + FFTH[i]
 end
 MIDC=MIDC+MID
 --mid = mid/1.1

 HIGH=0
 for i=HIGHDIV+1,255 do
  HIGH = HIGH + FFTH[i]
 end
 HIGHC=HIGHC+HIGH
 --high=high/4
end

-- Effects

Proxima = 14
PR_p={}
PR_np=127
PR_tc=0
function Proxima_BOOT()
 
 for i=0,PR_np do
  PR_p[i]={x=rand(240.0),y=rand(136.0),sx=rand(10.0)-5,sy=rand(10.0)-5}
 end
end

function Proxima_DRAW(it,ifft)
  n = 255//PR_np

  q={}
  for i=0,PR_np do
   v=PR_p[i]
   v.x=(v.x+v.sx/5*sin(i/10+it)*it)%240
   v.y=(v.y+v.sy/8*sin(i/11+it)*it)%136
   q[i]=v
  end
  --table.sort(q, function (a,b) return a.x < b.x end)
  for i=0,PR_np do
   v=q[i]
   fi=FFTH[i]*(.15+i/60) * EControl
   pix(v.x,v.y,fi*500)
   
   for j=i,PR_np do
    w=q[j] -- why not q[j]?
    d=(v.x-w.x)^2 + (v.y-w.y)^2
    d=d^.5
    n=(i+j)/2
    fj=FFTH[j]*(.15+j/60) * EControl
    ft = (fi + fj)
    if d < ft * 100 and i ~= j then
     line(v.x,v.y,w.x,w.y,ft*100)
     for l=j,PR_np do
      z=q[l] -- q?  
      d=(v.x-z.x)^2 + (v.y-z.y)^2
      d=d^.5
      fl = FFTH[l]*(.15+l/60) * EControl
      ft = fi + fj + fl
      if d < ft * 25 and l ~= j and l ~= i then
       tri(v.x,v.y,w.x,w.y,z.x,z.y,ft*100)
       goto continue
      end
     end
    end
   end
    ::continue::
  end
end

FFTCirc = 13
FC_osize=20

function FFTCirc_DRAW(it,ifft)
  size=FC_osize+ifft*2 + EControl

  tt=it
  for t=0,255 do
   a=(t/255+tt)*tau
   k=t//3
   c=((FFTH[(k-1)%256]+FFTH[(k+1)%256])/2+FFTH[k])*600*((k/255)*1.5+.015)

   x=(size)*sin(a)
   y=(size)*cos(a)
   x1=(size+c/4*EControl)*sin(a)
   y1=(size+c/4*EControl)*cos(a)
   --pix(120+x,68+y,1+c)
   line(120+x,68+y,120+x1,68+y1,1+min(14,c))
  end
end

ParaFlower = 12

PF_depth = 3
PF_t=0
function ParaFlower_DRAW(it,ifft)
 PF_t=PF_t+1
 for y=0+(PF_t%4)//1,135,4 do 
  for x=0,239 do
   X=x-120
   Y=y-68
   a=math.atan(X,Y)
   d=math.sqrt(X^2+Y^2)
   pix(x,y,8+8*sin((5*ifft)*sin((PF_depth+EControl)*a+it*tau)+d/10+it))
  end
 end
end

BrokenEgg = 11
BE_p={}
BE_sz=25
BE_depth=5

function BrokenEgg_DRAW(it,ifft)
 BE_p={}
 it=it*tau*(EControl+.5)
 for i=1,BE_sz^2 do
  y=i//(BE_sz/2)-BE_sz/2 + FFTH[mm((i/10)%256,0,255)//1]*100*i/255
  a=(i%BE_sz)/BE_sz*tau
  d=BE_sz/2*sin(it/BE_depth)+BE_sz*sin(y/BE_sz)
  x=d*sin(a+it/13)
  z=d*cos(a+it/13)
  a2=it/11
  BE_p[i]={x=x*cos(a2)-y*sin(a2),y=y*cos(a2)+x*sin(a2),z=z}
 end
 for i=2,#BE_p do
  line(120+BE_p[i].x*BE_p[i].z/9+20*sin(BE_p[i].y/5),
       58+BE_p[i].y*BE_p[i].z/9,
       120+BE_p[i-1].x*BE_p[i-1].z/9+20*sin(BE_p[i-1].y/5),
       58+BE_p[i-1].y*BE_p[i-1].z/9,
       mm((abs(BE_p[i-1].z)+abs(BE_p[i].z))/2,0,15))
 end
end

CircleColumn = 10

CC_p={}
CC_sz = 25

function CircleColumn_DRAW(it,ifft)
  it=it*tau
  CC_p={}
  for i=1,CC_sz^2 do
   y=i//(CC_sz/2)-CC_sz/2
   a=(i%CC_sz)/CC_sz*tau
   d=CC_sz+CC_sz/3*math.cos(y/5+it/4)+FFTH[mm(i/10+5,0,255)//1]*(i/255)*500-- ifft
   x=d*sin(a+it/7+sin(y/CC_sz))
   z=d*cos(a+it/7+sin(y/CC_sz))
   CC_p[i]={x=x,y=y,z=z}
  end
  table.sort(CC_p, function(a,b) return b.z > a.z end)
  for i=1,#CC_p do
   if CC_p[i].z > 15+EControl then
    circ(120+CC_p[i].x*CC_p[i].z/9+20*sin(CC_p[i].y/5),48+CC_p[i].y*CC_p[i].z/5,CC_p[i].z/5,mm(CC_p[i].z/2,0,15))
   end
  end
end

Chladni = 9
ChN=2000
ChNP=3
ChV=0.5
ChPV=-.2
Chd=1
ChPX={}
ChPY={}
ChT=0 
ChTT=0
ChPTX={}
ChPTY={}
Chfreq=.75
ChNPKD = 15

function ChResetPoints(it)
 for i=1,ChNP do
  ChPTX[i]=120-ChNPKD/2+ChNPKD*i/3+30*sin(it/20+ i/ChNP * 2 * pi)
  ChPTY[i]=68-ChNPKD/2+ChNPKD*i/3+26*cos(it/20+i/ChNP * 2 * pi)
 end
end

function Chladni_BOOT()
   ChResetPoints(0)
   for i=1,ChN do
    ChPX[i] = rand(240);
    ChPY[i] = rand(136);
   end
end

function Chladni_DRAW(it,ifft)
  ChT=it--ChT+.2
  ChTT=(it*10)//1--ChTT+1
  ChResetPoints(it)
  
  if ChTT%100 == 0 then
   ChNP = 3 + EControl*rand()
   Chfreq = .3 + rand()
   ChNPKD = 10 + 30*rand()
   Chladni_BOOT()
  end
 
  for i=1,ChN do
   R=0
   D=0
   C=0
   for j=1,ChNP do
    sx = ChPTX[j]
    sy = ChPTY[j]
    
    L=math.sqrt((ChPX[i]-sx)^2 + (ChPY[i]-sy)^2)
    C=C + sin(tau*Chfreq*(ChT-(L/ChV))/60)
 
    L=math.sqrt((ChPX[i]+d-sx)^2 + (ChPY[i]-sy)^2)
    R=R + sin(tau*Chfreq*(ChT-(L/ChV))/60)
 
    L=math.sqrt((ChPX[i]-sx)^2 + (ChPY[i]+Chd-sy)^2)
    D=D + sin(tau*Chfreq*(ChT-(L/ChV))/60)
   end
   C=math.abs(C)
   R=math.abs(R)
   D=math.abs(D)
  
   circ(ChPX[i],ChPY[i],4-C*2,(1.5-C)*10)
   
   L=math.sqrt((R-C)^2 + (D-C)^2)
   
   ChPX[i]=ChPX[i] + (ChPV * (R-C)/L)
   ChPY[i]=ChPY[i] + (ChPV * (D-C)/L)
   
   if ChPX[i] < 0 or ChPX[i] > 240 or ChPY[i] < 0 or ChPY[i] > 136 or C <0.0025 then
    ChPX[i] = rand(240);
    ChPY[i] = rand(136);
   end 
  end
  
  for i=1,ChNP do
   line(ChPTX[i],ChPTY[i]-2,ChPTX[i],ChPTY[i]+2,15)
   line(ChPTX[i]-2,ChPTY[i],ChPTX[i]+2,ChPTY[i],15)
   --circ(ChPTX[i],ChPTY[i],4,15)
  end
end

SwirlTunnel = 8

function SwirlTunnel_DRAW(it,ifft)
  it=it/10
  k=sin(it*tau)*99
  l=sin(it*tau*2)*49
  for i=0,32639 do
  x=i%240-k-120
  y=i/240-l-68
  u=m.atan2(y,x)
  d=(x*x+y*y)^.5
  v=99/d
 --  c=sin(v+sin((u+sin(v)*sin(it/9)*2)*tau)+it)
  c=sin(v+(u+sin(v)*sin(ifft/4)*tau)+t/1000)+1
  poke4(i,mm(c*8-c*((138-d)/138),0,15))
  end
  --circ(k+120,l+68,9+5*sin(it/9),EControl)
end

CloudTunnel = 7
function CloudTunnel_BOOT()
end

function CloudTunnel_DRAW(it,ifft)
 for i=0,32639 do
  x=i%240-120
  y=i//240-68
  s=sin(it)
  c=cos(it)
  k=(x*s-y*c)%40-20
  l=(y*s+x*c)%40-20
  d=(x*x+y*y)^.5
  a=math.atan2(y,x)
  e=(k*k+l*l)^.5
  c=((99/d)*(e/30+sin(it)+ ifft)-a*2.55 )%8+EControl
  poke4(i,c)
 end
end

TunnelWall = 6

function TunnelWall_DRAW(it,ifft)
  it=it/2
 for x=0,239 do
  for y=0,135 do
    sx=x-120*sin(it)
    sy=y-68 
    r=99+50*sin(it/3) - EControl*2
    s=sin(it)
    c=cos(it)
    X=(sx*s-sy*c)
    Y=(sy*s+sx*c)
    k=X%r-r/2
    l=Y%r-r/2
    a=math.atan2(k,l)
    e=(k*k+l*l)^.5  
    K=X//r 
    L=Y//r 
    ff = mm(abs(K+L)//1 + 10,0,255)
    ff = FFTH[ff]*.2+K
    pix(x,y,((99/e)*2*sin(it*ff+K+L)-a*2.55)%(8)+K+L*4)
  end
 end
end

Quup = 5

function Quup_DRAW(it,ifft)
 tt=it/8 * EControl
 P=3+tt//5%5
 Q=P/2
 I=tt/15%1
 for i=1,20 do
  for j=0,P-1,1 do
   r=tt+pi*j/Q-i*sin(tt/50)
   n=120+(i+I)*9*sin(r)
   o=68+(i+I)*9*cos(r)
   r=tt+pi*(j+1)/Q-i*sin(tt/50)
   line(n,o,120+(i+I)*9*sin(r),68+(i+I)*9*cos(r),i+1)
   l=i-1
   r=tt+pi*j/Q-l*sin(tt/50)
   if i>1 then 
    k=(l+I)*9 
   else 
    k=l*9 
   end
   line(n,o,120+k*math.sin(r),68+k*cos(r),i+1)
  end
 end
end


ATTunnel = 4

function ATTunnel_BOOT()
end

function ATTunnel_DRAW(it,ifft)
 ta=ss((it*4)%4/4,0,1)
 for j=1,20 do
  n=3+j
  d=(4*j-it%64)
  if d~=0 then d=99/d end
  if d<120 and d >5 then 
   w=(ifft*2)*d/6
   chroma=.01*(1+sin(ta))
   cr=ss((it/4+2*j)%5,2,4)*tau+EControl*it/2
   if j%2 == 0 then
    for i=1,n do
     if (it/4%8 < 4) then
      arc(120,68,w,d,cr + tau/n*i +j/10,pi/n,12)
     else
      arc(120,68,1,d*(1-chroma),cr + tau/n*i +j/10,pi/n,2)
      arc(120,68,1,d+w,cr + tau/n*i +j/10,pi/n,10)
      arc(120,68,w,d,cr + tau/n*i +j/10,pi/n,12)
     end
    end
   else
    for i=1,n do
     if (it/4%6 < 3) then
      tangent(120,68,1,d-1,cr + tau/n*i +j/10,d,0)
      tangent(120,68,w,d,cr + tau/n*i +j/10,d,11+(j/2)%4)
     else
      tangent(120,68,1,d*(1-chroma),cr + tau/n*i +j/10,d,1)
      tangent(120,68,1,d*(1+chroma),cr + tau/n*i +j/10,d,9)
      tangent(120,68,w,d,cr + tau/n*i +j/10,d,11+(j/2)%4)
     end
    end
   end
  end
 end
end

FujiTwist = 3
Fuji_lines = {}
Fuji_drawlines = {}
Fuji_frames = {}
Fuji_width=16
Fuji_height=120
Fuji_numframes=240
OldLogos={}
OL_ID=1

function FujiTwist_BOOT()
 for y=1,Fuji_height do
  bend= 1.5*Fuji_width*m.exp((y/Fuji_height)^2)--+w/5
   
  local k={cx=-bend,cy=y+(136-Fuji_height)/2,r=-Fuji_width/2}
  local l={cx=0,cy=y+(136-Fuji_height)/2,r=-Fuji_width/2}
  local o={cx=bend,cy=y+(136-Fuji_height)/2,r=-Fuji_width/2}
  table.insert(Fuji_lines,k)
  table.insert(Fuji_lines,l)
  table.insert(Fuji_lines,o)
 end
   
 for j=1,Fuji_numframes do
  Fuji_drawlines={}
  a=j/Fuji_numframes *tau
  for i=1,#Fuji_lines do
   ln=Fuji_lines[i]
   cx=ln.cx
   cy=ln.cy
   x=ln.r
     
   a1=sin(a)
   a2=sin(a+tau/4)
   a3=sin(a+tau/2)
   a4=sin(a+tau/4*3)
    
   ay=cx*sin(-a)
   az=cx*cos(-a)
    
   x1=x*a1+ay
   x2=x*a2+ay
   x3=x*a3+ay
   x4=x*a4+ay
    
   if (x1<x2) then
    c=(1+(a1+a2)/2)*8+2
    table.insert(Fuji_drawlines,{x1,cy,x2,cy,c,az})
   end
   if (x2<x3) then
    c=(1-((a2+a3)/(2)))*16
    c=(1+(a2+a3)/2)*8+2
    table.insert(Fuji_drawlines,{x2,cy,x3,cy,c,az})
   end
   if (x3<x4) then
    c=(1+(a3+a4)/2)*8+2
    table.insert(Fuji_drawlines,{x3,cy,x4,cy,c,az})
   end
   if (x4<x1) then
    c=(1+(a4+a1)/2)*8+2
    table.insert(Fuji_drawlines,{x4,cy,x1,cy,c,az})
   end
  end
  table.sort(Fuji_drawlines, function (a,b) return a[6] < b[6] end)
  Fuji_frames[j]=Fuji_drawlines
 end

 table.insert(OldLogos,Fuji_frames)
end

function c64_BOOT()
  c64_lines={}
  c64_drawlines={}
  c64_frames={}
  l1y=Fuji_height*4/12
  l2y=Fuji_height*4/8+Fuji_height/16
  
  numpoints=Fuji_height*10
  p1={}
  p2={}
  
  cls()
  circ(110,52,50,1)
  circ(110,52,34,0)
  rect(120,0,120,136,0)
  
  rect(120,36,34,14,1)
  rect(120,54,34,14,1)
  
  tri(140,52,160,32,160,72,0)
  
  for y=1,Fuji_height do
   -- fuck it search by image
   space=136-Fuji_height
   c=1
   for x=0,240 do
    if c==1 and pix(x,y) == 1 then
     c1=x
     c=2
    elseif c==2 and pix(x,y) == 0 then
     c2=x
      
     r=c1-c2
     l={cx=r/2+x-120, cy=y+space, r=r}
     table.insert(c64_lines,l)
     c=1
    end
   end
  end
 
  for j=1,Fuji_numframes do
    c64_drawlines={}
   a=math.pi/2+j/Fuji_numframes *tau
   for i=1,#c64_lines do
    ln=c64_lines[i]
    cx=ln.cx
    cy=ln.cy
    x1=cx-ln.r/2
    x2=cx+ln.r/2
    z1=-Fuji_width/2
    z2=Fuji_width/2
    
    a1=sin(a-tau/8)
    a2=sin(a+tau/8)
    a3=sin(a+tau*3/8)
    a4=sin(a+tau*5/8)
 
    X1=x1*cos(a)-z2*sin(a)
    Z1=x1*sin(a)+z2*cos(a)
    X2=x1*cos(a)-z1*sin(a)
    Z2=x1*sin(a)+z1*cos(a)
    X3=x2*cos(a)-z1*sin(a)
    Z3=x2*sin(a)+z1*cos(a)
    X4=x2*cos(a)-z2*sin(a)
    Z4=x2*sin(a)+z2*cos(a)
    if(X1 < X2) then
     c=(X2-X1)/ln.r*4
     c=(1+(a1+a2)/2)*8+2
     table.insert(c64_drawlines,{X1,cy,X2,cy,c,(Z1+Z2)/2})
    end
    if(X2 < X3) then
     c=(X3-X2)/Fuji_width * 15
     c=(1-((a2+a3)/(2)))*16
     table.insert(c64_drawlines,{X2,cy,X3,cy,c,(Z2+Z3)/2})
    end
    if(X3 < X4) then
     c=(X4-X3)/ln.r * 15
     c=(1+(a3+a4)/2)*8+2
     table.insert(c64_drawlines,{X3,cy,X4,cy,c,(Z3+Z4)/2})
    end
    if(X4 < X1) then
     c=(X1-X4)/Fuji_width * 15
     c=(1+(a4+a1)/2)*8+2
     table.insert(c64_drawlines,{X4,cy,X1,cy,c,(Z4+Z1)/2})
    end
   end
   table.sort(c64_drawlines, function (a,b) return a[6] < b[6] end)
   c64_frames[j]=c64_drawlines
  end

  table.insert(OldLogos,c64_frames)
 end

function FujiTwist_BDR(l)
  ftt=BASSC/100
  grader=sin(ftt*11/5+l/30)+1
  gradeg=sin(ftt*11/3+l/30)+1
  gradeb=sin(ftt*11/2+l/30)+1
  for i=0,15 do
   poke(0x3fc0+i*3,  mm(i*16*(grader),0,255))
   poke(0x3fc0+i*3+1,mm(i*16*(gradeg),0,255))
   poke(0x3fc0+i*3+2,mm(i*16*(gradeb),0,255))
  end
end

-- TODO: separate by lines for faster draw
function FujiTwist_DRAW(it,ifft)
 bnc=sin(ifft)*10
 frames = OldLogos[OL_ID]
 for y=1,Fuji_height do
  twist=Fuji_numframes*(1+cos(it/4*tau)+BASS/4*cos(y/Fuji_height))/2
  dl=frames[twist//1%Fuji_numframes+1]
  for i=1,#dl do
   ln=dl[i]
   if ln[2] == y then  
    line(120+ln[1],ln[2]+bnc,120+ln[3],ln[4]+bnc,ln[5])
   end
  end
 end
end

SunBeat = 2
SunBeatPAL = {}

function SunBeat_BOOT()
 for i=0,15 do
  SunBeatPAL[i*3]=mm(i*32,0,255)
  SunBeatPAL[i*3+1]=mm(i*24-128,0,255)
  SunBeatPAL[i*3+2]=mm(i*24-256,0,255)
 end
end

function SunBeat_BDR(l)
 --if l~=0 then return end
 PAL_Switch(SunBeatPAL,0.05)
end

function SunBeat_DRAW(it,ifft)
 if(it%1>=0.95) then
  for y=0,136 do 
   for x=0,240 do
    pix(x,y,((math.pi*math.atan(x-120,y-68))+t)%4+1)
   end 
  end 
  circ(120,68,50+5*math.sin(t/150),15)
 end
end

TwistFFT = 1

TF_size=200
function TwistFFT_BOOT()
end

function TwistFFT_BDR(l)
 local lm=68-abs(68-l)
 for i=0,47 do
  poke(16320+i,mm(sin(i)^2*i*lm/5.5,0,255))
 end
end

function TwistFFT_DRAW(it,ifft)
  it=it*10*EControl
 -- lets do the twist again
 for i=0,239 do
  local x=(i-it//1)%240
  local fhx = (FFTH[(x-1)%240]+FFTH[(x)%240]+FFTH[(x+1)%240])/3*(.9+x/60)
  local a=sin(it/10)* x/80

  local d=TF_size*fhx+5+5*BASS

  local cy = 68+10*BASS*sin(i/110+ it/12)

  local y1=d*sin(a)
  local y2=d*sin(a + tau/4)
  local y3=d*sin(a + tau/2)
  local y4=d*sin(a + tau*3/4)

  d=d/4

  if y1 < y2 then
   line(i,cy+y1,i,cy+y2,mm(d,0,15))
  end
  if y2 < y3 then
   line(i,cy+y2,i,cy+y3,mm(d+1,0,15))
  end
  if y3 < y4 then
   line(i,cy+y3,i,cy+y4,mm(d+2,0,15))
  end
  if y4 < y1 then
   line(i,cy+y4,i,cy+y1,mm(d+3,0,15))
  end
 end 
end

-- Modifiers

OOrder = 0
EOrder = 0
function ModifierHandler(COrder,IOrder,Mod, MT,MC)
  if COrder == IOrder then
    if Mod == 0 then
    elseif Mod == PIXNoise then
     PIXNoise_DRAW(1000*HIGH,MC)
    elseif Mod == PIXZoom then
     PIXZoom_DRAW(1000*HIGH,MC)
    elseif Mod == GridDim then
     GridDim_DRAW(1000*HIGH, MT,MC)
    elseif Mod == POSTCirc then
     POSTCirc_DRAW(1000*HIGH, MT,MC)
    elseif Mod == PIXMotionBlur then
      PIXMotionBlur_DRAW(1000*HIGH,MT,MC)
    elseif Mod == PIXJumpBlur then
      PIXJumpBlur_DRAW(1000*HIGH,MT,MC)
    end
    else
  end
end

PIXNoise = 1
function PIXNoise_DRAW(amount, mc)
 for i=0,amount do
  x=rand(240)-1
  y=rand(136)-1
  pix(x,y,mm(pix(x,y)-mc,0,15))
 end
end

PIXZoom = 2

function PIXZoom_DRAW(amount, mc)
 d=1+2*rand()
 for i=1,amount do
  x=240*rand()
  y=136*rand()
  a=math.atan(x-120,y-68)

  op=pix(x,y)-mc
  if op >= 0 then
   pix(x+d*(sin(a)+sin(t/300)),y+d*(cos(a)+sin(t/300)),op)
  else
   pix(x+d*sin(a),y+d*cos(a),0)
  end
 end
end

GridDim = 3

function GridDim_DRAW(amount, mt, mc)
 i=0
 for y=-1,36 do
  for x=-1,60 do
   i=i+1
   if i > amount*5 then return end
   sx=x*4+(mt*20)%4
   sy=y*4+(mt*5)%4
   pix(sx,sy,mm(pix(sx,sy)-1,0,255))
  end
 end
end

POSTCirc = 4

function POSTCirc_DRAW(amount, mt,mc)
  it=mt*40
  lim = mm(8+mc,0,15)
  for y=0,135 do 
   for x=0,239 do
    Y=(68-y)
    X=(120-x)
    d=math.sqrt(X^2+Y^2)//1
    a=math.atan2(X,Y)
    if((10*sin(it/4+d/5))%100>50) then
     c=pix(x,y)
     if c>lim then
      pix(x,y,mm(c-8,0,15))
     end
    end 
   end 
  end
end

PIXMotionBlur = 5
PMBsize = 20
function PIXMotionBlur_DRAW(amount, mt, mc)
 size=PMBsize+(mt)%5
 limit=50 + mc
 for i=0,amount/4 do
  d=2+size+rand(limit)
  a=rand()*tau
  x=d*sin(a)
  y=d*cos(a)
  if x >= -119 and x <= 118 and y >=-67 and y <= 66 then
   pix(120+x,68+y,mm(((pix(120+x,68+y)+pix(120+x-1,68+y-1)+pix(120+x+1,68+y-1)+pix(120+x-1,68+y+1)+pix(120+x+1,68+y+1))/4.8),0,15))
  end
 end
    
 for i=0,amount do
  d=size+rand(limit)
  a=rand()*tau
  x=d*sin(a)
  y=d*cos(a)
  if x >= -120 and x <= 119 and y >=-68 and y <= 67 then
   pix(120+x,68+y,pix(120+(d-1)*sin(a),68+(d-1)*cos(a)))
  end
 end
end

PIXJumpBlur = 6
function PIXJumpBlur_DRAW(amount, mt, mc)
  size=10+(mt)%5
  limit=100 + mc
  cx=120 cy=68
  tt=BASS%1
  for i=0,tt*50 do
    d=rand()
    d=1-(d^1.5)
    d1=size+d*(limit-tt*10)
    d2=1+d1+tt*10
    a=rand()*tau
    x=d1*sin(a)
    y=d1*cos(a)
    line(cx+(d1)*sin(a),cy+(d1)*cos(a),cx+(d2)*sin(a),cy+(d2)*cos(a),pix(cx+x,cy+y))
  end
     
  amount = min(amount,500)
  for i=0,amount do
   d=rand()
   d=1-(d^1.5)
   d=d*(size//1+limit*1.5)
   a=rand()*tau
   x=cx+d*sin(a)
   y=cy+d*cos(a)
   if x >= 1 and x <= 239 and y >=1 and y <= 134 then
    pix(cx+(d+1)*sin(a),cy+(d+1)*cos(a),mm((pix(x,y)+pix(x+1,y+1)+pix(x+1,y-1)+pix(x-1,y+1)+pix(x-1,y-1))/4.8,0,15))
   end
  end
 end
 
--[[

--]]

Texts={{"GOOD","TO BE","BACK IN","THE EWERK",""},
      {"MANTRA\nTRONIC","+ + +","MADTRIX","2023"}}
TImages={}

-- Overlays

TextBounceUp = 1
function TextBounceUp_DRAW(it,ifft)
 if ODivider ~= 0 then
  tt=t/BT//ODivider
  tx=abs(tt)%#Texts[TextID] + 1
  y=140-160*(it%1)
 else
  tt=t/BT//1
  tx=abs(tt)%#Texts[TextID] + 1
  -- count how many line breaks
  linecount=1
  for i=1, #Texts[TextID][tx] do
    if string.sub(Texts[TextID][tx],i,i) == "\n" then linecount=linecount+1 end
  end
  y=68 - (3+OControl)*3 *linecount
 end
 tc=mm(MID*15,8,15)
 tl=print(Texts[TextID][tx],0,-100,15,false,3+OControl)
 print(Texts[TextID][tx],120-tl/2,y,tc,false,3+OControl)
end

SunSatOrbit = 2
function SunSatOrbit_DRAW(it,ifft)
  c=mm(ifft*6,0,15)
  t1=(it/1000)%1
  if t1 < .5 then
   t1=(t1-.25)*tau
   circ(120+500*sin(t1),68+20*cos(t1),10,c)
  else
   t1=(t1+.25)*math.pi*2
   sx=120+500*sin(t1)
   sy=68+20*cos(t1)
   print(" ___ ",0+sx,0+sy,c,true)
   print("  |  ",0+sx,4+sy,c,true)
   print("##=##",0+sx,8+sy,c,true)
   print("  |  ",0+sx,12+sy,c,true)
   print(" ___ ",0+sx,13+sy,c,true)
  end 
end

SmilyFaces = 3
NumSmilyFaces = 30
SmilyFaces_xysr = {}
function SmilyFaces_BOOT()
 for i=1,NumSmilyFaces do
  SmilyFaces_xysr[i]={rand(300),rand(200)-32,rand(20)+10,rand()*tau}
 end
 table.sort(SmilyFaces_xysr, function (a,b) return a[3]<b[3] end)
end

function SmilyFaces_DRAW(it,ifft)
 nsf = mm(OControl,1,NumSmilyFaces)
 for i=1,nsf do
  local sm=SmilyFaces_xysr[i]
  x=(sm[1])%300 - 30
  y=(sm[2]+FFTC[i]*2*i^0.8)%200 - 32
  s=(sm[3])
  a=sin(FFTC[i]*2)-tau/4

  ds = s/20
  x1=9*sin(a)-7*cos(a)
  y1=9*cos(a)+7*sin(a)
  x2=-9*sin(a)-7*cos(a)
  y2=-9*cos(a)+7*sin(a)
  circ(x,y,s,(i%15)+1)
  circ(x+x1*ds,y+y1*ds,4*ds,0)
  circ(x+x2*ds,y+y2*ds,4*ds,0)
  l=15*ds
  for j=-l,l do
   circ(x+12*ds*sin(j/l+a+tau/4),y+10*ds*cos(j/l+a+tau/4),1,0)
  end
 end
end

TextWarp = 4
TWp={}
TWfirst = true

function ScreenToPoints()
  local p={}
  for y=0,135 do 
    for x=0,239 do
     if pix(x,y) == 12 then 
      if x < 80 then c = 6 
      elseif x < 160 then c = 12
      else c = 3
      end
      d=((x-120)^2+(y-68)^2)^.5
      a=m.atan2(x-120,y-68)
      nx=d*sin(a)
      ny=d*cos(a)
      
      table.insert(p,{x,y,c,a,d})
    end
   end
  end 
  return p
end

function TextWarp_BOOT()
  cls()
  l=print("2 WEEKS",-100,-100,12,false,5)
  print("2 WEEKS",120-l/2,10,12,false,5)
  
  l=print("TO",-100,-100,12,false,5)
  print("TO",120-l/2,40,12,false,5)
  
  l=print("REVISION",-100,-100,12,false,5)
  print("REVISION",120-l/2,70,12,false,5)
  
  l=print("HYPE!!!!",-100,-100,12,false,5)
  print("HYPE!!!!",120-l/2,100,12,false,5)
  
  l=print("fuck fuck fuck fuck",200,230,12,false,1)
  print("fuck fuck fuck fuck",120-l/2,130,12,false,1)

  TWp = ScreenToPoints()
  table.insert(TImages,TWp)

  cls()
  l=print("MAN",-100,-100,12,true,5)
  print("MAN",120-l/2,10,12,true,5)
  
  l=print("TRA",-100,-100,12,true,5)
  print("TRA",120-l/2,40,12,true,5)
  
  l=print("TRO",-100,-100,12,true,5)
  print("TRO",120-l/2,70,12,true,5)
  
  l=print("NIC",-100,-100,12,true,5)
  print("NIC",120-l/2,100,12,true,5)
  
  TWp = ScreenToPoints()
  table.insert(TImages,TWp)

  cls()
  l=print("RiFT",-100,-100,12,true,9)
  print("RiFT",120-l/2,40,12,true,9)
  
  TWp = ScreenToPoints()
  table.insert(TImages,TWp)
end

function TextWarp_DRAW(it,ifft)
 it=sin(it/4*tau)^2
 TWp = TImages[mm(TIimageID,1,#TImages)]
 for i=1,#TWp do
  pp=TWp[i]
  b=pp[4]+2*pi*sin(it*pp[5]/100+MID)
  w=pp[5]/2+10*sin(pp[5]/40*BASS)+(it/OControl)*pp[5]+HIGH
  nx=w*sin(b)
  ny=w*cos(b)
  pix(120+nx,68+ny,15)-- pp[3])
 end
end

Snow = 5
function Snow_BOOT()
end
function Snow_DRAW(it,ifft)
  for i=0,OControl do
    circ(rand(240),rand(136),rand(4),it)
  end
end

SmokeCircles = 6
SC_p={}
SC_np = 99
function SmokeCircles_BOOT()
  for i=0,SC_np do
    SC_p[i]={x=4-8*rand(),y=4-8*rand(),z=20*rand()}
  end
end

function SmokeCircles_DRAW(it,ifft)
  it=it*5
  for i=0,SC_np do
    z=(SC_p[i].z+it)%20
    x=SC_p[i].x
    y=SC_p[i].y
    t2=-(1-z/9)
    X=x*cos(t2)-y*sin(t2)
    Y=y*cos(t2)+x*sin(t2)
    circ(120+X*z,68+Y*z,20-z,15-(z/1.5))
  end
end

Spiral = 7

function Spiral_DRAW(it,ifft)
 it=it*30
 for i=0,200 do
  j=(i/10+it)%120
  i2=i/20
  i2=i2*i2
  z=j+i2
  X=sin(j)*z
  Y=cos(j)*z
  circ(120+X,68+Y,z/10-OControl*2,mm(15*j/120,0,15))
 end
end

Bobs = 8
function Bobs_DRAW(it,ifft)
  for i=0,99 do
    j=i/12
    x=10*sin(pi*j+it)
    y=10*cos(pi*j+it)
    z=10*sin(pi*j)
    X=x*sin(it)-z*cos(it)
    Z=x*cos(it)+z*sin(it)
    circ(120+X*Z,68+y*Z,Z,OControl*MID)
  end
end

JoyDivision = 9
JD_ffts={}
JD_oldffts={}
JD_ft={}
JD_fi=0
JD_ot=0
function JoyDivision_BOOT()
 for i=1,8 do
  table.insert(JD_ffts,{})
 end
end

function JoyDivision_DRAW(it,ifft)
 if JD_ot%OControl == 0 then
  JD_ft={}
  for j=0,255 do
   table.insert(JD_ft,FFTH[j])
  end
  JD_oldffts=JD_ffts
  JD_ffts={}
  table.insert(JD_ffts,JD_ft)
  for i=1,7 do
   table.insert(JD_ffts,JD_oldffts[i])
  end
 end
 JD_ot = JD_ot + 1
    
 rectb(46,4,146,110,15)
    
 int=0
 for i=1,#JD_ffts do
  JD_ft=JD_ffts[i]
  if #JD_ft > 0 then
   for j=1,127 do
    k=(JD_ft[j*2]+JD_ft[j*2+1])*(j/255 + .05)
    k=k*400
    int=(int + k)/2
    pix(54+j,8+i*12-int,15-i/4)
   end
  end
 end

 print("Tic80 Division",54,116,15)
end

LineCut = 10

function LineCut_DRAW(it,ifft)
	s=10+OControl
	x=(it*s*2)%s*4
  --n=

	for sx=-136,240+s+136,s*4 do
    for y=0,136+s,s do
    
     cx=sx-y+x
      
      tri(cx,y-s,cx-s,y,cx,y+s,1)
      tri(cx,y-s,cx+s,y,cx,y+s,1)
      --[[
      tri(cx,y-s/3,cx-s/2,y,cx,y+s/3,3)
      tri(cx,y-s/3,cx+s/2,y,cx,y+s/3,3)
      tri(cx,y-s/4,cx-s/3,y,cx,y+s/4,5)
      tri(cx,y-s/4,cx+s/3,y,cx,y+s/4,5)
      tri(cx,y-s/5,cx-s/4,y,cx,y+s/5,7)
      tri(cx,y-s/5,cx+s/4,y,cx,y+s/5,7)
      --]]
  end
 end
end

-- TestSheet
TestSheetPAL={}
function TestSheet_BOOT()
 TestSheetPAL=PAL_make3(0,0,0,255,30,0,255,255,255)
 --TestSheetPAL=PAL_make2(0,0,0,255,255,255)
end
function TestSheet_BDR(l)
 PAL_Switch(TestSheetPAL,0.1)
end
function TestSheet_DRAW(it,ifft)
 for i=0,15 do
  print(i,i*10,10,12)
  rect(i*10,20,10,10,i)
 end
end

VolTest = 6

function VolTest_DRAW(it,ifft)
 for i=239,0,-1 do
  for j=0,135 do
   pix(i,j,(pix(i+1,j)))
  end
 end
 line(239,0,239,136,0)

 print("TIME",0,20,3)
 pix(239,20+t/1000,3)
 print("TBEAT",0,50,6)
 pix(239,60+bt,6)
 print("TBASS",0,80,9)
 pix(239,100+BASS,9)
 print("TBASSC",0,110,12)
 pix(239,110+BASSC/100,12)
end

-- Palettes

PAL_STATE=0 -- 1: changing, 0: static, -1:perline
PAL_MOD=0 -- 0: done
PAL_CURRENT=0

function PAL_make2(r1,g1,b1,r2,g2,b2)
 local pal={}
 for i=0,15 do
  pal[i*3]   = mm(r1*abs(15-i)/15 + r2*abs(i)/15,0,255)
  pal[i*3+1] = mm(g1*abs(15-i)/15 + g2*abs(i)/15,0,255)
  pal[i*3+2] = mm(b1*abs(15-i)/15 + b2*abs(i)/15,0,255)
 end
 return pal
end

function PAL_make3(r1,g1,b1,r2,g2,b2,r3,g3,b3)
 local pal={}
 for i=0,7 do
  pal[i*3]   = mm(r1*abs(7-i)/7 + r2*abs(i)/7,0,255)
  pal[i*3+1] = mm(g1*abs(7-i)/7 + g2*abs(i)/7,0,255)
  pal[i*3+2] = mm(b1*abs(7-i)/7 + b2*abs(i)/7,0,255)
 end
 for i=1,8 do
  pal[21+i*3]   = mm(r2*abs(8-i)/8 + r3*abs(i)/8,0,255)
  pal[21+i*3+1] = mm(g2*abs(8-i)/8 + g3*abs(i)/8,0,255)
  pal[21+i*3+2] = mm(b2*abs(8-i)/8 + b3*abs(i)/8,0,255)
 end
 return pal
end

Sweetie16=0
Sweetie16PAL={}

BlueOrange=1
BlueOrangePAL={}

Reddish=2
ReddishPAL={}

BlueGreySine=5
BlueGreySinePAL={}

GreyScale = 6
GreyScalePAL = {}

OverBrown = 8
OverBrownPAL={}

function PAL_BOOT()
  for i=0,47 do
    Sweetie16PAL[i]=peek(0x3fc0+i)

    BlueOrangePAL[i]=mm(sin(i)^2*i,0,255)

    BlueGreySinePAL[i]=sin(i/15)*255

    GreyScalePAL[i]=i*5.6
  end

  for i=0,15 do
    ReddishPAL[i*3]=mm(i*32,0,255)
    ReddishPAL[i*3+1]=mm(i*24-128,0,255)
    ReddishPAL[i*3+2]=mm(i*24-256,0,255)

    OverBrownPAL[i*3]=math.min(255,20+i*32)
    OverBrownPAL[i*3+1]=math.min(255,10+i*24)
    OverBrownPAL[i*3+2]=i*17
    
   end
  
end

function PAL_Switch(ip, speed)
 --[[
 if PAL_STATE ~= 1 then
  PAL_STATE = 1
  return
 end
 
 if PAL_STATE == 1 and peek(0x3fc0+15) == ip[15] then
  PAL_STATE = 0
  return
 end
 --]]
 local noneed
 for i=0,47 do
  ic=peek(0x3fc0+i)
  nc=ip[i] 
  if ic ~= nc//1 then 
   poke(0x3fc0+i, mm(ic*(1-speed)+(nc)*speed,0,255))
  end
 end
end

function PAL_Fade(ip,l)
 local lm=68-abs(68-l)
 for i=0,47 do
  poke(0x3fc0+i, mm(ip[i]*lm/5.5,0,255))
 end
end

-- pastels
Pastels = 3

-- TODO smooth ffs
function PAL_Rotate1(it,l)
  it=it/8
  for i=0,47 do
    poke(16320+i,(sin(it/8*sin(i//3)+(i%3)))*99)
  end
end

Dutch = 4
function PAL_Rotate2(it,l)
  grader=sin(it*1/7+l/150)+1
  gradeg=sin(it*1/13+l/150)+1
  gradeb=sin(it*1/11+l/150)+1
  for i=0,15 do
   poke(0x3fc0+i*3,  mm(i*16*(grader),0,255))
   poke(0x3fc0+i*3+1,mm(i*16*(gradeg),0,255))
   poke(0x3fc0+i*3+2,mm(i*16*(gradeb),0,255))
  end
end

Dimmed = 7
function PAL_Rotate3(it,l)
 for i=0,15 do
  r=i*(8+8*(sin(tau/6*5+it+l/100)))
  poke(0x3fc0+i*3,mm(r,0,255))
  g=i*(8+8*(math.sin(it+l/100)))
  poke(0x3fc0+i*3+1,mm(g,0,255))
  b=i*(8+8*(math.cos(it+l/100)))
  poke(0x3fc0+i*3+2,mm(b,0,255))
 end
end    

SlowWhite = 9
function PAL_SlowWhite(it)
 ta=96*(sin(it/10)+1)
 tb=96*(sin(it/10+tau/3)+1)
 tc=96*(sin(it/10+tau*4/3)+1)

 for i=0,7 do
  poke(0x3fc0+i*3,(i/7*(ta)) )
  poke(0x3fc0+i*3+1,(i/7*(tb)) )
  poke(0x3fc0+i*3+2,(i/7*(tc)) )
 end
 for i=8,15 do
  poke(0x3fc0+i*3,math.min(255,(15-i)/7*ta + (i-7)/8*255) )
  poke(0x3fc0+i*3+1,math.min(255,(15-i)/7*tb + (i-7)/8*255) )
  poke(0x3fc0+i*3+2,math.min(255,(15-i)/7*tc + (i-7)/8*255) )
 end
end

Inverted = 10
function PAL_Rotate4(it,l)
 it=it/8
 grader=sin(it*1/7+l/150)+1
 gradeg=sin(it*1/13+l/150)+1
 gradeb=sin(it*1/11+l/150)+1
 for i=0,15 do
  poke(0x3fc0+i*3, 255-(8+4*grader)*i)
  poke(0x3fc0+i*3+1, math.max(0,math.min(255,255-(8+4*gradeg)*i)))
  poke(0x3fc0+i*3+2, math.max(0,math.min(255,255-(8+4*gradeb)*i)))
 end
end

function PAL_Handle(np,l)
 if np == Sweetie16 then
  PAL_Switch(Sweetie16PAL,0.1)
 elseif np == BlueOrange then
  PAL_Fade(BlueOrangePAL,l)
 elseif np == Reddish then
  PAL_Switch(ReddishPAL,0.1)
 elseif np == Pastels then
  PAL_Rotate1(t/BT,l)
 elseif np == Dutch then
  PAL_Rotate2(t/BT,l)
 elseif np == BlueGreySine then
  PAL_Switch(BlueGreySinePAL,0.1)
 elseif np == GreyScale then
  PAL_Switch(GreyScalePAL,0.1)
 elseif np == Dimmed then
  PAL_Rotate3(t/BT,l)
 elseif np == OverBrown then
  PAL_Switch(OverBrownPAL,0.1)
 elseif np == SlowWhite then
  PAL_SlowWhite(t/BT,l)
 elseif np == Inverted then
  PAL_Rotate4(t/BT,l)
 end
end

-- Keyboard Control
Effect=1
Overlay=0
EModifier=0
OModifier=0
Loudness=1
ECLS=true
OCLS=true

EControl = 1
OControl = 1
EPalette = 0
OPalette = 0

EMControl = 1
OMControl = 1

-- ie, beat, BASS, pos/neg
ETimerMode=0
OTimerMode=1
EDivider=1
ODivider=1
ETimer=0
OTimer=0

-- Tmodes
TNONE=0
TTIME=1
TBEAT=2
TBASS=3
TBASSC=4
TMID=5
TMIDC=6
THIGH=7
THIGHC=8

DEBUG=false

-- Beat timing
BT=10 -- beat time in ms
BTA={}
BEATS=4
LBT=0
BTC=0
bt=0

TextID=1
TIimageID=1

function BEATTIME_BOOT()
 for i=1,BEATS do
  BTA[i]=0
 end
 BTC=0
end

function KEY_CHECK()
 -- 1-26: A-Z
 -- 27-36: 0-9

 -- panic! (alt)
 if key(65) then
  -- q: effect
  if keyp(17) == true then
   Effect = 1
   EControl = 1
   ETimerMode=0
   EDivider=1
   EPalette = 0
  end

  -- 1: effect mod
  if keyp(28) == true then
    EModifier=0
    EMControl = 1
  end

  -- z: effect mod
  if keyp(26) == true then
    OModifier=0
    OMControl = 1
  end

  -- a: overlay
  if keyp(1) == true then
   Overlay = 1
   OControl = 1
   OTimerMode=0
   ODivider=1
   OPalette = 0
  end


   
  return
 end

 -- shift
 if key(64) then
 -- left: increase 3d logo
  if keyp(60) then
   OL_ID = OL_ID + 1
  end
  
  -- right: decrease 3d logo
  if keyp(61) then
   OL_ID = OL_ID + 1
  end
  
  OL_ID = mm(OL_ID%(#OldLogos+1),1,#OldLogos)
 end

 -- Beat detection/input
 if keyp(48,10000,10) == true then
  local currentbeat=mm((BTC+1)%BEATS,1,BEATS)
  BTA[currentbeat]= time()-LBT
  LBT=time()
  BTC=currentbeat
  local beatssum = 0
  for i=1,BEATS do
   beatssum=beatssum+BTA[i]
  end
  BT=beatssum/BEATS
 end
 
 -- home: Loudness up by 0.1
 if keyp(56) then
  if key(64) then -- shift, change FFTH_length by 1
    FFTH_length = FFTH_length + 1
  else
   Loudness = Loudness + 0.1
  end
 end

 -- end: Loudness down by 0.1
 if keyp(57) then
  if key(64) then -- shift, change FFT_Length by 1
    FFTH_length = FFTH_length - 1
  else
   Loudness = Loudness - 0.1
  end
 end

 Loudness = mm(Loudness,0.1,10)
 FFTH_length = mm(FFTH_length,2,60)

 -- up: increase text image
 if keyp(58) then
  TIimageID = TIimageID + 1
 end

 -- down: decrease text image
 if keyp(59) then
  TIimageID = TIimageID + 1
 end

 TIimageID = mm(TIimageID%(#TImages+1),1,#TImages)

 -- left: increase text image
 if keyp(60) then
  TextID = TextID + 1
 end
  
 -- right: decrease text image
 if keyp(61) then
  TextID = TextID + 1
 end
  
 TextID = mm(TextID%(#Texts+1),1,#Texts)
  
 -- insert: effect cls switch
 if keyp(53) == true then
  if ECLS == true then 
   ECLS = false
  else
   ECLS = true
  end
 end

 -- pageup: effect modifier order switch
 if keyp(54) == true then
  if EOrder == 0 then 
    EOrder = 1
  else
    EOrder = 0
  end
 end
 
 -- q: effect down
 if keyp(17) == true then
  Effect = Effect - 1
 end

 -- w: effect up
 if keyp(23) == true then
  Effect = Effect + 1
 end
 
 Effect = mm(Effect%(NumEffects+1),0,NumEffects)

 -- TODO: key instead of keyp? limit?
 -- e: effect control down
 if keyp(5) == true then
  EControl = EControl - 1
 end 

 -- r: effect control up
 if keyp(18) == true then
  EControl = EControl + 1
 end 
  
 -- t: effect timer down
 if keyp(20) == true then
  ETimerMode = ETimerMode - 1
 end

 -- y: effect timer up
 if keyp(25) == true then
  ETimerMode = ETimerMode + 1
 end

 ETimerMode = mm(ETimerMode,0,NumModes)

 -- u: effect divider down
 if keyp(21) == true then
  EDivider = EDivider - 1
 end

 -- i: effect divider up
 if keyp(9) == true then
  EDivider = EDivider + 1
 end
 EDivider = mm(EDivider,-10,10)

 -- o: effect palette down
 if keyp(15) == true then
  EPalette = EPalette - 1
 end 

 -- p: effect palette up
 if keyp(16) == true then
  EPalette = EPalette + 1
 end 

 EPalette = mm(EPalette%(NumPalettes+1),0,NumPalettes)
 
 -- 1: effect modifier down
 if keyp(28) == true then
  EModifier = EModifier - 1
 end

 -- 2: effect modifier up
 if keyp(29) == true then
  EModifier = EModifier + 1
 end
 
 EModifier = mm(EModifier%(NumModifiers+1),0,NumModifiers)
 
 -- 3: effect modifier control down
 if keyp(30) == true then
  EMControl = EMControl - 1
 end

 -- 4: effect modifier control up
 if keyp(31) == true then
  EMControl = EMControl + 1
 end
 
 -- z: overlay modifier down
 if keyp(26) == true then
  OModifier = OModifier - 1
 end

 -- x: overlay modifier up
 if keyp(24) == true then
  OModifier = OModifier + 1
 end
 
 OModifier = mm(OModifier%(NumModifiers+1),0,NumModifiers)

 -- c: overlay modifier control down
 if keyp(3) == true then
  OMControl = OMControl - 1
 end

 -- v: overlay modifier control up
 if keyp(22) == true then
  OMControl = OMControl + 1
 end
 
 -- TODO: key instead of keyp? limit?
 -- d: overlay control down
 if keyp(4) == true then
  OControl = OControl - 1
 end 

 -- f: overlay control up
 if keyp(6) == true then
  OControl = OControl + 1
 end 
  
 -- g: overlay timer down
 if keyp(7) == true then
  OTimerMode = OTimerMode - 1
 end

 -- h: overlay timer up
 if keyp(8) == true then
  OTimerMode = OTimerMode + 1
 end

 OTimerMode = mm(OTimerMode,0,NumModes)

 -- j: overlay divider down
 if keyp(10) == true then
  ODivider = ODivider - 1
 end

 -- k: overlay divider up
 if keyp(11) == true then
  ODivider = ODivider + 1
 end
 ODivider = mm(ODivider,-10,10)

 -- l: overlay palette down
 if keyp(12) == true then
  OPalette = OPalette - 1
 end 

 -- ;: overlay palette up
 if keyp(42) == true then
  OPalette = OPalette + 1
 end 

 OPalette = mm(OPalette%(NumPalettes+1),0,NumPalettes)

 -- delete: overlay cls switch
 if keyp(52) == true then
  if OCLS == true then 
   OCLS = false
  else
   OCLS = true
  end
 end

 -- pagedown: effect modifier order switch
 if keyp(55) == true then
  if OOrder == 0 then 
    OOrder = 1
  else
    OOrder = 0
  end
 end
 
 -- a: overlay down
 if keyp(1) == true then
  Overlay = Overlay - 1
 end

 -- s: overlay up
 if keyp(19) == true then
  Overlay = Overlay + 1
 end
 
 Overlay = mm(Overlay%(NumOverlays+1),0,NumOverlays)
 

 -- slash: debug switch
 if keyp(47) == true then
  if DEBUG == true then 
   DEBUG = false
  else
   DEBUG = true
  end
 end

 -- backspace: exit
 if keyp(51) == true then
  exit()
 end
 
end


function BDR(l)
 vbank(0)
 PAL_Handle(EPalette,l)

 vbank(1)
 PAL_Handle(OPalette,l)
end

function BOOT()
 FFT_BOOT()
 BEATTIME_BOOT()
 PAL_BOOT()
 
 TestSheet_BOOT()
 SunBeat_BOOT()
 SmilyFaces_BOOT()
 FujiTwist_BOOT()
 c64_BOOT()
 SmokeCircles_BOOT()
 Chladni_BOOT()
 TextWarp_BOOT()
 JoyDivision_BOOT()
 Proxima_BOOT()
end

function TIC()t=time()
 vbank(0)

 -- should remove mouse pointer but doesnt
 poke(0x3ffb,4)

 bt=((t-LBT))/(BT)
 
 if ECLS then 
  cls()
 end

 FFT_FILL()
 KEY_CHECK()

 -- Effect timer mode and speed
 -- pos to add Beat% and Volume (all ffth)
 local ed = abs(EDivider)
 if ETimerMode == TTIME then
  ET=t/1000/(2^ed)
 elseif ETimerMode == TBEAT then
  ET=(bt/(2^ed))%4
 elseif ETimerMode == TBASS then
  ET=BASS*5/(2^ed)
 elseif ETimerMode == TBASSC then
  ET=BASSC/50/(2^ed)
elseif ETimerMode == TMID then
  ET=MID*8/(2^ed)
 elseif ETimerMode == TMIDC then
  ET=MIDC/40/(2^ed)
elseif ETimerMode == THIGH then
  ET=HIGH*5/(2^ed)
 elseif ETimerMode == THIGHC then
  ET=HIGHC/100/(2^ed)
else
  ET=0
 end
 if EDivider < 0 then
  ET = -ET
 end
 
 ModifierHandler(EOrder,0,EModifier, ET,EMControl)

 if Effect == 0 then
  VolTest_DRAW(t,t)
 elseif Effect == TwistFFT then
  TwistFFT_DRAW(ET,0)
 elseif Effect == SunBeat then
  SunBeat_DRAW(ET,0)
 elseif Effect == FujiTwist then
  FujiTwist_DRAW(ET,MID)
 elseif Effect == ATTunnel then
  ATTunnel_DRAW(ET,MID)
 elseif Effect == Quup then
  Quup_DRAW(ET,MID)
 elseif Effect == TunnelWall then
  TunnelWall_DRAW(ET,MID)
 elseif Effect == CloudTunnel then
  CloudTunnel_DRAW(ET,MID)
 elseif Effect == SwirlTunnel then
  SwirlTunnel_DRAW(ET,BASS)
 elseif Effect == Chladni then
  Chladni_DRAW(ET,BASS)
 elseif Effect == CircleColumn then
  CircleColumn_DRAW(ET,BASS)
 elseif Effect == BrokenEgg then
  BrokenEgg_DRAW(ET,BASS)
 elseif Effect == ParaFlower then
  ParaFlower_DRAW(ET,BASS)
 elseif Effect == FFTCirc then
  FFTCirc_DRAW(ET,BASS)
 elseif Effect == Proxima then
  Proxima_DRAW(ET,BASS)
 end
 
 ModifierHandler(EOrder,1,EModifier, ET,EMControl)

 vbank(1)
 if OCLS then 
  cls()
 end
 
 -- Overlay timer mode and speed
 local od = abs(ODivider)
 if OTimerMode == TTIME then
  OT=(t/1000)/(2^od)
 elseif OTimerMode == TBEAT then
  OT=(bt/(2^od))%4
 elseif OTimerMode == TBASS then
  OT=(BASS*5)/(2^od)
 elseif OTimerMode == TBASSC then
  OT=(BASSC/50)/(2^od)
elseif OTimerMode == TMID then
  OT=MID*8/(2^od)
 elseif OTimerMode == TMIDC then
  OT=MIDC/40/(2^od)
elseif OTimerMode == THIGH then
  OT=HIGH*5/(2^od)
 elseif OTimerMode == THIGHC then
  OT=HIGHC/100/(2^od)
 else
  OT=0
 end
 if ODivider < 0 then
  OT = -OT
 end

 ModifierHandler(OOrder,0,OModifier, OT,OMControl)

 if Overlay == 0 then
 elseif Overlay == TextBounceUp then
  TextBounceUp_DRAW(OT,OT)
 elseif Overlay == SunSatOrbit then
  SunSatOrbit_DRAW(OT,OT)
 elseif Overlay == SmilyFaces then
  SmilyFaces_DRAW(OT,OT)
 elseif Overlay == TextWarp then
  TextWarp_DRAW(OT,OT)
 elseif Overlay == Snow then
  Snow_DRAW(OT,OT)
 elseif Overlay == SmokeCircles then
  SmokeCircles_DRAW(OT,OT)
 elseif Overlay == Spiral then
  Spiral_DRAW(OT,OT)
 elseif Overlay == Bobs then
  Bobs_DRAW(OT,OT)
 elseif Overlay == JoyDivision then
  JoyDivision_DRAW(OT,OT)
elseif Overlay == LineCut then
  LineCut_DRAW(OT,OT)
 end

 ModifierHandler(OOrder,1,OModifier, OT,OMControl)

 if DEBUG == true then
  print("Effect: "..Effect.."|Ctrl: "..EControl.."|Timer: "..ETimerMode.."|Sped: "..EDivider.."|Pal: "..EPalette,0,100,12)
  print("EModifier: "..EModifier.."|Ctrl: "..EMControl,0,108,12)
  print("Overlay: "..Overlay.."|Ctrl: "..OControl.."|Timer: "..OTimerMode.."|Sped: "..ODivider.."|Pal: "..OPalette,0,116,12)
  print("OModifier: "..OModifier.."|Ctrl: "..OMControl,0,124,12)
 end
end

--[[
 if(it%423==77) then
  print("LOVE",40,20,15,false,7)
  print("BYTE",50,80,15,false,7)
end
if(t%423==218) then
print("RIFT",50,20,15,false,7)
print("TLC",60,80,15,false,7)
end
if(t%423==359) then
print("#BUZZ",20,20,15,false,7)
print("<3ALL",20,80,15,false,7)
end
--]]

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

