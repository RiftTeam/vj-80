-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua

t=0

N=2000
NP=3
V=0.5
PV=-.2
d=1
PX={}
PY={}
T=0
TT=0
PTX={}
PTY={}

freq=.75
NPKD = 15

function ResetPoints()
 for i=1,NP do
  PTX[i]=120-NPKD/2+NPKD*i/3+30*math.sin(t/2000+ i/NP * 2 * math.pi)
  PTY[i]=68-NPKD/2+NPKD*i/3+26*math.cos(t/2000+i/NP * 2 * math.pi)
 end
end

function setup()
 for i=1,NP do
  --PushRanCirc()
 end
 ResetPoints()
 for i=1,N do
  PX[i] = math.random(240);
  PY[i] = math.random(136);
 end
 for i=0,47 do
-- poke(0x3fc0+i,((i+1)%3+1)/2*i*6)
 poke(0x3fc0+i,i*5.6)
 end
end

setup()
function TIC()
 t=time()
 T=T+.2
 TT=TT+1
 ResetPoints()
 cls()
 
 if TT%100 == 0 then
  NP = 3+ 3*math.random()
  freq=.1+math.random()
  NPKD = 10 + 30*math.random()
  setup()
 end

 for i=1,N do
  R=0
  D=0
  C=0
  for j=1,NP do
   sx = PTX[j]
   sy = PTY[j]
   
   L=math.sqrt((PX[i]-sx)^2 + (PY[i]-sy)^2)
   C=C + math.sin(2*math.pi*freq*(T-(L/V))/60)

   L=math.sqrt((PX[i]+d-sx)^2 + (PY[i]-sy)^2)
   R=R + math.sin(2*math.pi*freq*(T-(L/V))/60)

   L=math.sqrt((PX[i]-sx)^2 + (PY[i]+d-sy)^2)
   D=D + math.sin(2*math.pi*freq*(T-(L/V))/60)
  end
  C=math.abs(C)
  R=math.abs(R)
  D=math.abs(D)
 
--  pix(PX[i],PY[i],(1-C)*16)
  circ(PX[i],PY[i],4-C*2,(1.5-C)*10)
  
  L=math.sqrt((R-C)^2 + (D-C)^2)
  
  PX[i]=PX[i] + (PV * (R-C)/L)
  PY[i]=PY[i] + (PV * (D-C)/L)
  
  if PX[i] < 0 or PX[i] > 240 or PY[i] < 0 or PY[i] > 136 or C <0.0025 then
   PX[i] = math.random(240);
   PY[i] = math.random(136);
  end 
 end
 
 for i=1,NP do
  circ(PTX[i],PTY[i],4,15)
 end
end

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

