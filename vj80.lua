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
FFTH_length=4
BASS=0
BASSC=0
BASSDIV=10
MID=0
MIDC=0
HIGHDIV=40
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
  f=fft(i)
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

Quup = 5

function Quup_DRAW(it,ifft)
 tt=it/8
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
 ta=ss(it%4/4,0,1)
 for j=1,20 do
  n=3+j
  d=(4*j-it%64)
  if d~=0 then d=99/d end
  if d<120 and d >5 then 
   w=d/6
   chroma=.01*(1+sin(ta))
   cr=ss((it/4+2*j)%5,2,4)*tau
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
  table.sort(Fuji_drawlines, function (a,b) return a[5] < b[5] end)
  Fuji_frames[j]=Fuji_drawlines
 end
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
 for y=1,Fuji_height do
  twist=Fuji_numframes*(1+cos(it/4*tau))/2
  dl=Fuji_frames[twist//1%Fuji_numframes+1]
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
 -- lets do the twist again
 for i=0,239 do
  local x=(i+it//1)%240
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
PIXNoise = 1
function PIXNoise_DRAW(amount)
 for i=0,amount do
  x=rand(240)-1
  y=rand(136)-1
  pix(x,y,mm(pix(x,y)-1,0,15))
 end
end

PIXZoom = 2

function PIXZoom_DRAW(amount)
 d=1+2*rand()
 for i=1,amount do
  x=240*rand()
  y=136*rand()
  a=math.atan(x-120,y-68)

  op=pix(x,y)-1
  if op >= 0 then
   pix(x+d*(sin(a)+sin(t/300)),y+d*(cos(a)+sin(t/300)),op)
  else
   pix(x+d*sin(a),y+d*cos(a),0)
  end
 end
end

-- Overlays
text={"LOVEBYTE", "10-12th FEB", "Online", "lovebyte.party"}

TextBounceUp = 1
function TextBounceUp_DRAW(it,ifft)
 tt=t//50
 tx=tt%#text + 1
 tc=max(8,min(15,MID+6))
 tl=print(text[tx],0,-100,15,false,3)
 print(text[tx],120-tl/2,100-40*ifft,tc,false,3)
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
 for i=1,NumSmilyFaces do
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
function PAL_BOOT()
  for i=0,47 do
    Sweetie16PAL[i]=peek(0x3fc0+i)

    BlueOrangePAL[i]=mm(sin(i)^2*i,0,255)
  end

  for i=0,15 do
    ReddishPAL[i*3]=mm(i*32,0,255)
    ReddishPAL[i*3+1]=mm(i*24-128,0,255)
    ReddishPAL[i*3+2]=mm(i*24-256,0,255)
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

function PAL_Handle(np,l)
 if np == Sweetie16 then
  PAL_Switch(Sweetie16PAL,0.1)
 elseif np == BlueOrange then
  PAL_Fade(BlueOrangePAL,l)
 elseif np == Reddish then
  PAL_Switch(ReddishPAL,0.1)
 elseif np == Pastels then
  PAL_Rotate1(ET,l)
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

DEBUG=false

NumEffects=5
NumOverlays=3
NumModifiers=2
NumModes=4
NumPalettes=3

-- Beat timing
BT=0 -- beat time in ms
BTA={}
BEATS=4
LBT=0
BTC=0
bt=0

function BEATTIME_BOOT()
 for i=1,BEATS do
  BTA[i]=0
 end
 BTC=0
end

function KEY_CHECK()
 -- 1-26: A-Z
 -- 27-36: 0-9
 
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
 
 -- insert: effect cls switch
 if keyp(53) == true then
  if ECLS == true then 
   ECLS = false
  else
   ECLS = true
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
 
 Effect = mm(Effect,0,NumEffects)

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

 EPalette = mm(EPalette,0,NumPalettes)

 -- 1: effect modifier down
 if keyp(28) == true then
  EModifier = EModifier - 1
 end

 -- 2: effect modifier up
 if keyp(29) == true then
  EModifier = EModifier + 1
 end
 
 EModifier = mm(EModifier,0,NumModifiers)

 -- z: overlay modifier down
 if keyp(26) == true then
  OModifier = OModifier - 1
 end

 -- x: overlay modifier up
 if keyp(24) == true then
  OModifier = OModifier + 1
 end
 
 OModifier = mm(OModifier,0,NumModifiers)

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

 OPalette = mm(OPalette,0,NumPalettes)

 -- delete: overlay cls switch
 if keyp(52) == true then
  if OCLS == true then 
   OCLS = false
  else
   OCLS = true
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
 
 Overlay = mm(Overlay,0,NumOverlays)
 

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
end

function TIC()t=time()
 vbank(0)
 bt=((t-LBT))/(BT)
 
 if ECLS then 
  cls()
 end

 FFT_FILL()
 KEY_CHECK()

 -- Effect timer mode and speed
 local ed = abs(EDivider)
 if ETimerMode == TTIME then
  ET=t/(2^ed)
 elseif ETimerMode == TBEAT then
  ET=bt/(2^ed)
 elseif ETimerMode == TBASS then
  ET=BASS/(2^ed)
 elseif ETimerMode == TBASSC then
  ET=BASSC/(2^ed)
 else
  ET=0
 end
 if EDivider < 0 then
  ET = -ET
 end
 
 if Effect == 0 then
  TestSheet_DRAW(t,t)
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
 end

 if EModifier == 0 then
 elseif EModifier == PIXNoise then
  PIXNoise_DRAW(1000*HIGH)
 elseif EModifier == PIXZoom then
  PIXZoom_DRAW(1000*HIGH)
 end

 vbank(1)
 if OCLS then 
  cls()
 end
 
 -- Overlay timer mode and speed
 local od = abs(ODivider)
 if OTimerMode == TTIME then
  OT=(t/1000)/(2^od)
 elseif OTimerMode == TBEAT then
  OT=bt/(2^od)
 elseif OTimerMode == TBASS then
  OT=(BASS*100)/(2^od)
 elseif OTimerMode == TBASSC then
  OT=(BASSC/100)/(2^od)
 else
  OT=0
 end
 if ODivider < 0 then
  OT = -OT
 end

 if Overlay == 0 then
 elseif Overlay == TextBounceUp then
  TextBounceUp_DRAW(OT,OT)
 elseif Overlay == SunSatOrbit then
  SunSatOrbit_DRAW(OT,OT)
 elseif Overlay == SmilyFaces then
  SmilyFaces_DRAW(OT,OT)
 end

 if OModifier == 0 then
 elseif OModifier == PIXNoise then
  PIXNoise_DRAW(1000*HIGH)
 elseif OModifier == PIXZoom then
  PIXZoom_DRAW(1000*HIGH)
 end

 if DEBUG == true then
  print("Effect: "..Effect.."|Ctrl: "..EControl.."|Timer: "..ETimerMode.."|Sped: "..EDivider.."|Pal: "..EPalette,0,100,12)
  print("EModifier: "..EModifier,0,108,12)
  print("Overlay: "..Overlay.."|Ctrl: "..OControl.."|Timer: "..OTimerMode.."|Sped: "..ODivider.."|Pal: "..OPalette,0,116,12)
  print("OModifier: "..OModifier,0,124,12)
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

