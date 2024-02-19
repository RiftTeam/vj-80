-- title:  goto80 lovebyte2024
-- author: mantratronic + ps
-- desc:   vj80
-- script: lua

package.path=package.path..";C:\\Users\\micro\\AppData\\Roaming\\com.nesbox.tic\\TIC-80\\mantratronic-vj-80\\?.lua"	-- jtruk

require("code/globals")
require("debug/fakefft")
FontBoot=require("code/font")

-- effects follow the template: {boot=function(), draw=function(), bdr=function()}
Effects={
  require("effect/vol_test"),
  require("effect/twist_fft"),
  require("effect/sun_beat"),
--  require("effect/fuji_twist"),
  require("effect/at_tunnel"),
  require("effect/quup"),
  require("effect/tunnel_wall"),
  require("effect/cloud_tunnel"),
  require("effect/swirl_tunnel"),
  require("effect/chladni"),
  require("effect/circle_column"),
  require("effect/broken_egg"),
  require("effect/para_flower"),
  require("effect/fft_circ"),
  require("effect/proxima"),
  require("effect/lemons"),
  require("effect/revision_back"),
  require("effect/bitnick"),
  require("effect/worms"),
}

--[[
  TextBounceUp_DRAW(OT,OT)
  SineBobs_DRAW(OT,OT)
  --SunSatOrbit_DRAW(OT,BASS)
  SmilyFaces_DRAW(OT,OT)
  TextWarp_DRAW(OT,OT)
  Snow_DRAW(OT,OT)
  SmokeCircles_DRAW(OT,OT)
  Spiral_DRAW(OT,OT)
  Bobs_DRAW(OT,OT)
  JoyDivision_DRAW(OT,OT)
  LineCut_DRAW(OT,OT)
  StickerLens_DRAW(OT,OT)
  RevisionTop_DRAW(OT,OT)
 --]]

-- overlays follow the template: {id='', boot=function(), draw=function(), bdr=function()}
Overlays = {
  require("overlay/smiley_faces"),
  --[[
	TextBounceUp,
	--SunSatOrbit,
	SineBobs,
	SmilyFaces,
	TextWarp,
	Snow,
	SmokeCircles,
	Spiral,
	Bobs,
	JoyDivision,
	LineCut,
	StickerLens
--	RevisionTop,
--	RevisionLogo,
--	MadtixxLogo
--]]
}

Modifiers={
  require("modifier/pix_noise"),
  require("modifier/pix_zoom"),
  require("modifier/grid_dim"),
  require("modifier/post_circ"),
  require("modifier/pix_motion_blur"),
  require("modifier/pix_jump_blur"),
  require("modifier/rot_vert"),
  require("modifier/rot_horz"),
  require("modifier/sft_vert"),
  require("modifier/sft_horz"),
  require("modifier/post_squares"),
  require("modifier/line_scratch"),
}

NumModes=8
NumPalettes=13

-- Utils

function clamp(x,a,b)
 return max(a,min(b,x))
end

function ss(x,e1,e2)
 y=clamp(x,e1,e2)
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

function flength(txt,kx,size)
	kx = kx or 1
  size = size or 1
	pcx = 0
	letter ={}
	for i=1,string.len(txt) do
		letter = font[string.sub(txt,i,i)]
		-- update kerning
		pcx = pcx + letter[5]*size + kx
	end
	return pcx
end

-- fprint ("text", x, y, [x kerning = 1],[y kerning = 1], [colour = 15])
function fprint(txt,tx,ty,kx,ky,tc,size)
	kx = kx or 1
	ky = ky or 1
	tc = tc or 10
  size = size or 1
	pcx = 0
	pcy = 0
	letter ={}
	-- set to blit segment (8 = BG-1)
	poke4(2*0x03ffc,8)
	-- set colour
	poke4(2*0x03FF0 + 1, tc)
	-- print each letter
	for i=1,string.len(txt) do
		letter = font[string.sub(txt,i,i)]
		spr(letter[1],tx+pcx,ty+pcy,0,size,0,0,letter[3],letter[4])

		-- update kerning
		pcx = pcx + letter[5]*size + kx
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

-- Modifiers

OOrder = 0
EOrder = 0
function ModifierHandler(COrder,IOrder,mod, MT,MC)
	local modifier = Modifiers[mod]
  if COrder == IOrder then
    if modifier ~= nil then
      modifier.draw({amount=1000*HIGH, mt=MT, mc=MC})
    end
  end
end

Texts={
  {"LOVEBYTE","2024","+ + +","GOTO80","+ + +"},
  {"ACID","DANCE","ROBOT","NINJA"},
  {"LOVE","LIFE","LIVE","LEFT","LOUD","LINE"},
  {"MATH","SINE","CIRC","LINE","CLS","RECT"},
  {"MUNCH","---"},
  {"I","DONT","KNOW"},
  {"SHALALA","---"},
  {"HARDCORE","FAMILY"},
  {"BREAK","BEAT","DANCE","HIT","HOP","SHOUT","SCREAM","JUMP"}
}
TImages={}

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
  pal[i*3]   = clamp(r1*abs(15-i)/15 + r2*abs(i)/15,0,255)
  pal[i*3+1] = clamp(g1*abs(15-i)/15 + g2*abs(i)/15,0,255)
  pal[i*3+2] = clamp(b1*abs(15-i)/15 + b2*abs(i)/15,0,255)
 end
 return pal
end

function PAL_make3(r1,g1,b1,r2,g2,b2,r3,g3,b3)
 local pal={}
 for i=0,7 do
  pal[i*3]   = clamp(r1*abs(7-i)/7 + r2*abs(i)/7,0,255)
  pal[i*3+1] = clamp(g1*abs(7-i)/7 + g2*abs(i)/7,0,255)
  pal[i*3+2] = clamp(b1*abs(7-i)/7 + b2*abs(i)/7,0,255)
 end
 for i=1,8 do
  pal[21+i*3]   = clamp(r2*abs(8-i)/8 + r3*abs(i)/8,0,255)
  pal[21+i*3+1] = clamp(g2*abs(8-i)/8 + g3*abs(i)/8,0,255)
  pal[21+i*3+2] = clamp(b2*abs(8-i)/8 + b3*abs(i)/8,0,255)
 end
 return pal
end

Sweetie16=0
Sweetie16PAL={}

OverBrown = 1
OverBrownPAL={}

Reddish=2
ReddishPAL={}

BlueGreySine=3
BlueGreySinePAL={}

GreyScale = 4
GreyScalePAL = {}

UKR=11
UKRPAL = {}

Trans=12
TransPAL = {}

Eire=13
EirePAL = {}

function PAL_BOOT()
  for i=0,47 do
    Sweetie16PAL[i]=peek(0x3fc0+i)

    BlueOrangePAL[i]=clamp(sin(i)^2*i,0,255)

    BlueGreySinePAL[i]=sin(i/15)*255

    GreyScalePAL[i]=i*5.6
  end

  for i=0,15 do
    ReddishPAL[i*3]=clamp(i*32,0,255)
    ReddishPAL[i*3+1]=clamp(i*24-128,0,255)
    ReddishPAL[i*3+2]=clamp(i*24-256,0,255)

    OverBrownPAL[i*3]=math.min(255,20+i*32)
    OverBrownPAL[i*3+1]=math.min(255,10+i*24)
    OverBrownPAL[i*3+2]=i*17
    
  end

  UKRPAL = PAL_make3(0,0,0,0x00,0x5b,0xbb,0xff,0xd5,0x00)
  TransPAL = PAL_make3(0x55,0xcd,0xfc,255,255,255,0xf7,0xa8,0xb8)
  EirePAL = PAL_make3(0x00,0x9a,0x44,255,255,255,0xff,0x82,0x00)

  OLDPALE = Sweetie16PAL
  OLDPALO = Sweetie16PAL
end


PAL_time = 0
PAL_done = true
PAL_olde = 0
PAL_oldo = 0
PAL_currente = 0
PAL_currento = 0
OLDPALE = {}
OLDPALO = {}
function PAL_Switch(ip, speed, buffer)
 if buffer == 0 and PAL_olde == PAL_currente then
  --print("pt:"..PAL_time.."|old:"..PAL_olde.."|new:"..PAL_currente.."|buffer:"..buffer.."|s:"..speed,10,30,15)
  return
 elseif buffer == 1 and PAL_oldo == PAL_currento then
  --print("new",10,40)
  return
 end

 if PAL_time >= 1 then
  if buffer == 0 then
   PAL_olde = PAL_currente
   OLDPALE = ip
  else 
   PAL_oldo = PAL_currento
   OLDPALO = ip
  end
  PAL_time = 0
 end

 PAL_time = clamp(PAL_time + speed,0,1)

 for i=0,47 do
  --ic=peek(0x3fc0+i)
  if buffer == 0 then
   ic = OLDPALE[i]
  else
   ic = OLDPALO[i]
  end
  nc = ip[i] 

  poke(0x3fc0+i, clamp(ic * (1-PAL_time) + nc *PAL_time,0,255))
 end

 --sprint("pt:"..PAL_time.."|old:"..PAL_olde.."|new:"..PAL_currente.."|buffer:"..buffer.."|s:"..speed,10,10,15)
end

BlueOrange=5
BlueOrangePAL={}

function PAL_Fade(ip,l)
 local lm=68-abs(68-l)
 for i=0,47 do
  poke(0x3fc0+i, clamp(ip[i]*lm/5.5,0,255))
 end
end

-- pastels
Pastels = 8

-- TODO smooth ffs
function PAL_Rotate1(it,l)
  it=it/8
  for i=0,47 do
    poke(16320+i,(sin(it/8*sin(i//3)+(i%3)))*99)
  end
end

Dutch = 6
function PAL_Rotate2(it,l)
  grader=sin(it*1/7+l/150)+1
  gradeg=sin(it*1/13+l/150)+1
  gradeb=sin(it*1/11+l/150)+1
  for i=0,15 do
   poke(0x3fc0+i*3,  clamp(i*16*(grader),0,255))
   poke(0x3fc0+i*3+1,clamp(i*16*(gradeg),0,255))
   poke(0x3fc0+i*3+2,clamp(i*16*(gradeb),0,255))
  end
end

Dimmed = 7
function PAL_Rotate3(it,l)
 for i=0,15 do
  r=i*(8+8*(sin(tau/6*5+it+l/100)))
  poke(0x3fc0+i*3,clamp(r,0,255))
  g=i*(8+8*(math.sin(it+l/100)))
  poke(0x3fc0+i*3+1,clamp(g,0,255))
  b=i*(8+8*(math.cos(it+l/100)))
  poke(0x3fc0+i*3+2,clamp(b,0,255))
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

function PAL_Handle(np,l,b)
 if np == Sweetie16 and l == 0 then
  if b == 0 then 
   PAL_currente = Sweetie16
  else
   PAL_currento = Sweetie16
  end
  PAL_Switch(Sweetie16PAL,0.01,b)
 elseif np == BlueOrange then
  PAL_Fade(BlueOrangePAL,l)
 elseif np == Reddish and l == 0 then
  if b == 0 then 
   PAL_currente = Reddish
  else
   PAL_currento = Reddish
  end
  PAL_Switch(ReddishPAL,0.01,b)
 elseif np == Pastels then
  PAL_Rotate1(t/BT,l)
 elseif np == Dutch then
  PAL_Rotate2(t/BT,l)
 elseif np == BlueGreySine and l == 0 then
  if b == 0 then 
   PAL_currente = BlueGreySine
  else
   PAL_currento = BlueGreySine
  end
  PAL_Switch(BlueGreySinePAL,0.01,b)
 elseif np == GreyScale and l == 0 then
  if b == 0 then 
    PAL_currente = GreyScale
   else
    PAL_currento = GreyScale
   end
   PAL_Switch(GreyScalePAL,0.01,b)
 elseif np == Dimmed then
  PAL_Rotate3(t/BT,l)
 elseif np == OverBrown and l == 0 then
  if b == 0 then 
    PAL_currente = OverBrown
   else
    PAL_currento = OverBrown
   end
   PAL_Switch(OverBrownPAL,0.01,b)
 elseif np == SlowWhite then
  PAL_SlowWhite(t/BT,l)
 elseif np == Inverted then
  PAL_Rotate4(t/BT,l)
 elseif np == UKR and l == 0 then
  if b == 0 then 
   PAL_currente = UKR
  else
   PAL_currento = UKR
  end
  PAL_Switch(UKRPAL,0.01,b)
 elseif np == Trans and l == 0 then
  if b == 0 then 
   PAL_currente = Trans
  else
   PAL_currento = Trans
  end
  PAL_Switch(TransPAL,0.01,b)
 elseif np == Eire and l == 0 then
  if b == 0 then 
   PAL_currente = Eire
  else
   PAL_currento = Eire
  end
  PAL_Switch(EirePAL,0.01,b)
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
ETimerMode=1
OTimerMode=1
EDivider=1
ODivider=1
ETimer=0
OTimer=0

EMT=0
OMT=0
EMTimerMode=1
OMTimerMode=1
EMDivider=1
OMDivider=1

-- stutter on beat
EStutter = 0
OStutter = 0

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

DEBUG=true

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
    EMTimerMode=0
    EMDivider=1
    EStutter=0
    ECLS=true
   end

  -- a: overlay
  if keyp(1) == true then
   Overlay = 1
   OControl = 1
   OTimerMode=0
   ODivider=1
   OPalette = 0
  end
  
  -- z: overlay modifier
  if keyp(26) == true then
    OModifier=0
    OMControl = 1
    OMTimerMode=0
    OMDivider=1
    OStutter=0
    OCLS=true
  end

   
  return
 end

 -- shift
 if key(64) then
 	if keyp(51) then
  	trace(
    "\nEffect = " .. Effect ..
   	"\nETimerMode = " .. ETimerMode ..
    "\nEDivider = " .. EDivider ..
    "\nEPalette = " .. EPalette ..
    "\nEModifier = " .. EModifier ..
    "\nEMControl = " .. EMControl ..
    "\nEMTimerMode = " .. EMTimerMode ..
    "\nEMDivider = " .. EMDivider ..
    "\nEStutter = " .. EStutter ..
    "\nECLS = " .. tostring(ECLS) ..
    "\nOverlay = " .. Overlays[Overlay] ..
    "\nOTimerMode = " .. OTimerMode ..
    "\nODivider = " .. ODivider ..
    "\nOControl = " .. OControl ..
    "\nOPalette = " .. OPalette ..
    "\nOModifier = " .. OModifier ..
    "\nOStutter = " .. OStutter ..
    "\nOCLS = " .. tostring(OCLS)
) 
  end
 
  -- set screens, 1-
  if keyp(28) == true then
    Effect = 2
				ETimerMode = 3
				EDivider = -6
				EPalette = 2
				EModifier = 0
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = false
				Overlay = 6
				OTimerMode = 1
				ODivider = 1
				OControl = 2
				OPalette = 13
				OModifier = 1
				OStutter = 0
				OCLS = false
   end

   if keyp(29) == true then
				Effect = 15
				ETimerMode = 1
				EDivider = 1
				EPalette = 5
				EModifier = 5
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = true
				Overlay = 4
				OTimerMode = 4
				ODivider = 6
				OControl = 13
				OPalette = 7
				OModifier = 5
				OStutter = 0
				OCLS = true
   end

   if keyp(30) == true then
    Effect = 1
				ETimerMode = 1
				EDivider = 1
				EPalette = 7
				EModifier = 6
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = false
				Overlay = 1
				OTimerMode = 1
				ODivider = 1
				OControl = 2
				OPalette = 5
				OModifier = 7
				OStutter = 0
				OCLS = true
   end

   if keyp(31) == true then
    Effect = 5
				ETimerMode = 1
				EDivider = 1
				EPalette = 2
				EModifier = 11
				EMControl = 33
				EMTimerMode = 4
				EMDivider = 1
				EStutter = 0
				ECLS = false
				Overlay = 8
				OTimerMode = 1
				ODivider = 1
				OControl = 6
				OPalette = 6
				OModifier = 11
				OStutter = 0
				OCLS = false
   end
   
   if keyp(31) == true then
	   Effect = 16
				ETimerMode = 5
				EDivider = 6
				EPalette = 1
				EModifier = 3
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = false
				Overlay = 10
				OTimerMode = 8
				ODivider = 0
				OControl = 4
				OPalette = 13
				OModifier = 1
				OStutter = 0
				OCLS = true
   end
   
   if keyp(32) == true then
	   Effect = 4
				ETimerMode = 1
				EDivider = 1
				EPalette = 0
				EModifier = 13
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = false
				Overlay = 7
				OTimerMode = 2
				ODivider = 6
				OControl = 3
				OPalette = 10
				OModifier = 13
				OStutter = 0
				OCLS = false
   end
   
   if keyp(33) == true then
	   Effect = 18
				ETimerMode = 2
				EDivider = 5
				EPalette = 1
				EModifier = 12
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = true
				Overlay = 10
				OTimerMode = 1
				ODivider = 1
				OControl = 1
				OPalette = 11
				OModifier = 2
				OStutter = 0
				OCLS = true
   end

   if keyp(34) == true then
	   Effect = 5
				ETimerMode = 2
				EDivider = 1
				EPalette = 11
				EModifier = 11
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = false
				Overlay = 3
				OTimerMode = 1
				ODivider = 1
				OControl = 15
				OPalette = 7
				OModifier = 2
				OStutter = 0
				OCLS = true
			end

   if keyp(35) == true then
				Effect = 17
				ETimerMode = 1
				EDivider = 1
				EPalette = 1
				EModifier = 12
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = false
				Overlay = 2
				OTimerMode = 3
				ODivider = 5
				OControl = 1
				OPalette = 9
				OModifier = 6
				OStutter = 0
				OCLS = true
			end
			
			if keyp(36) == true then
				Effect = 4
				ETimerMode = 5
				EDivider = 3
				EPalette = 4
				EModifier = 13
				EMControl = 1
				EMTimerMode = 1
				EMDivider = 1
				EStutter = 0
				ECLS = true
				Overlay = 8
				OTimerMode = 1
				ODivider = 1
				OControl = 1
				OPalette = 13
				OModifier = 12
				OStutter = 0
				OCLS = false
			end
			
			if keyp(37) == true then			
				Effect = 18
				ETimerMode = 1
				EDivider = 1
				EPalette = 7
				EModifier = 7
				EMControl = 0
				EMTimerMode = 3
				EMDivider = 0
				EStutter = 0
				ECLS = false
				Overlay = 11
				OTimerMode = 3
				ODivider = 1
				OControl = 1
				OPalette = 5
				OModifier = 13
				OStutter = 0
				OCLS = true
			end

 -- left: increase 3d logo
  if keyp(60) then
   OL_ID = OL_ID + 1
  end
  
  -- right: decrease 3d logo
  if keyp(61) then
   OL_ID = OL_ID - 1
  end
  
  OL_ID = clamp(OL_ID%(#OldLogos+1),1,#OldLogos)

  -- home: FFTH_length up by 1
  if keyp(56) then
      FFTH_length = FFTH_length + 1
  end
 
 -- end: FFT_Length down by 1
 if keyp(57) then
  FFTH_length = FFTH_length - 1
 end 
 FFTH_length = clamp(FFTH_length,2,60)

 -- insert: stutter effect cls switch
 if keyp(53) == true then
  if EStutter == 0 then 
   EStutter = 1
  else
   EStutter = 0
  end
 end

 -- delete: stutter overlay cls switch
 if keyp(52) == true then
  if OStutter == 0 then 
   OStutter = 1
  else
   OStutter = 0
  end
 end

 return
 end

 -- Beat detection/input
 if keyp(48,10000,10) == true then
  local currentbeat=clamp((BTC+1)%BEATS,1,BEATS)
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
   Loudness = Loudness + 0.1
 end

 -- end: Loudness down by 0.1
 if keyp(57) then
   Loudness = Loudness - 0.1
 end

 Loudness = clamp(Loudness,0.1,10)

 -- up: increase text image
 if keyp(58) then
  TIimageID = TIimageID + 1
 end

 -- down: decrease text image
 if keyp(59) then
  TIimageID = TIimageID + 1
 end

 TIimageID = clamp(TIimageID%(#TImages+1),1,#TImages)

 -- left: decrease text image
 if keyp(60) then
  TextID = TextID - 1
  if TextID < 1 then TextID = #Texts end
 end
  
 -- right: increase text image
 if keyp(61) then
  TextID = TextID + 1
  if TextID > #Texts then TextID = 1 end
 end
  
 --TextID = clamp(TextID%(#Texts+1),1,#Texts)
  
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
  if Effect < 1 then Effect = #Effects end
 end

 -- w: effect up
 if keyp(23) == true then
  Effect = Effect + 1
  if Effect > #Effects then Effect = 1 end
 end
 
 --Effect = clamp(Effect%(#Effects+1),0,#Effects)

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

 ETimerMode = clamp(ETimerMode,0,NumModes)

 -- u: effect divider down
 if keyp(21) == true then
  EDivider = EDivider - 1
 end

 -- i: effect divider up
 if keyp(9) == true then
  EDivider = EDivider + 1
 end
 EDivider = clamp(EDivider,-10,10)

 -- o: effect palette down
 if keyp(15) == true then
  EPalette = EPalette - 1
 end 

 -- p: effect palette up
 if keyp(16) == true then
  EPalette = EPalette + 1
 end 

 EPalette = clamp(EPalette%(NumPalettes+1),0,NumPalettes)
 
 -- 1: effect modifier down
 if keyp(28) == true then
  EModifier = EModifier - 1
  if EModifier < 1 then EModifier = #Modifiers end
 end

 -- 2: effect modifier up
 if keyp(29) == true then
  EModifier = EModifier + 1
  if EModifier > #Modifiers then EModifier = 1 end
 end
 
 --EModifier = clamp(EModifier%(NumModifiers+1),0,NumModifiers)
 
 -- 3: effect modifier control down
 if keyp(30) == true then
  EMControl = EMControl - 1
 end

 -- 4: effect modifier control up
 if keyp(31) == true then
  EMControl = EMControl + 1
 end
 
 -- 5: effect modifier timer down
 if keyp(32) == true then
  EMTimerMode = EMTimerMode - 1
 end

 -- 6: effect modifier timer up
 if keyp(33) == true then
  EMTimerMode = EMTimerMode + 1
 end

 EMTimerMode = clamp(EMTimerMode,0,NumModes)

 -- 7: effect modifier divider down
 if keyp(34) == true then
  EMDivider = EMDivider - 1
 end

 -- 8: effect modifier divider up
 if keyp(35) == true then
  EMDivider = EMDivider + 1
 end
 EMDivider = clamp(EMDivider,-10,10)

 -- z: overlay modifier down
 if keyp(26) == true then
  OModifier = OModifier - 1
  if OModifier < 1 then OModifier = #Modifiers end
 end

 -- x: overlay modifier up
 if keyp(24) == true then
  OModifier = OModifier + 1
  if OModifier > #Modifiers then OModifier = 1 end
 end
 
 --OModifier = clamp(OModifier%(NumModifiers+1),0,NumModifiers)

 -- c: overlay modifier control down
 if keyp(3) == true then
  OMControl = OMControl - 1
 end

 -- v: overlay modifier control up
 if keyp(22) == true then
  OMControl = OMControl + 1
 end

 -- b: overlay modifier timer down
 if keyp(2) == true then
  OMTimerMode = OMTimerMode - 1
 end
  
 -- n: effect modifier timer up
 if keyp(14) == true then
  OMTimerMode = OMTimerMode + 1
 end
  
 OMTimerMode = clamp(OMTimerMode,0,NumModes)
  
 -- m: overlay modifier divider down
 if keyp(13) == true then
  OMDivider = OMDivider - 1
 end
  
 -- ,: overlay modifier divider up
 if keyp(45) == true then
  OMDivider = OMDivider + 1
 end
 OMDivider = clamp(OMDivider,-10,10)
  
 -- a: overlay down
 if keyp(1) == true then
  Overlay = Overlay - 1
  if Overlay < 1 then Overlay = #Overlays end
 end

 -- s: overlay up
 if keyp(19) == true then
  Overlay = Overlay + 1
  if Overlay > #Overlays then Overlay = 1 end
 end
 
 --Overlay = clamp(Overlay%(NumOverlays+1),0,NumOverlays)
  
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

 OTimerMode = clamp(OTimerMode,0,NumModes)

 -- j: overlay divider down
 if keyp(10) == true then
  ODivider = ODivider - 1
 end

 -- k: overlay divider up
 if keyp(11) == true then
  ODivider = ODivider + 1
 end
 ODivider = clamp(ODivider,-10,10)

 -- l: overlay palette down
 if keyp(12) == true then
  OPalette = OPalette - 1
 end 

 -- ;: overlay palette up
 if keyp(42) == true then
  OPalette = OPalette + 1
 end 

 OPalette = clamp(OPalette%(NumPalettes+1),0,NumPalettes)

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
 
 
 -- backslash: debug switch
 if keyp(41) == true then
  cls()
  
  if DEBUG == true then 
   DEBUG = false
  else
   DEBUG = true
  end
 end

 -- backspace: exit
 --if keyp(51) == true then
 -- exit()
 --end
 
end


function BDR(l)
 vbank(0)
 PAL_Handle(EPalette,l,0)

 vbank(1)
 PAL_Handle(OPalette,l,1)
end

function BOOT()
  FFT_BOOT()
  BEATTIME_BOOT()
  PAL_BOOT()
  FontBoot()

  for _,effect in ipairs(Effects) do
    if effect.boot then
      effect.boot()
    end
  end

  for _,overlay in ipairs(Overlays) do
    if overlay.boot then
      overlay.boot()
    end
  end
end

function TIC()
	
 -- remove mouse pointer but doesnt
 poke(0x3ffb,4)
	
	t=time()
 
 vbank(0)

 bt=((t-LBT))/(BT)
 
 if EStutter == 1 and SBT ~= bt//1 then
  if ECLS == true then ECLS = false else ECLS = true end
 end
 if OStutter == 1 and SBT ~= bt//1 then
  if OCLS == true then OCLS = false else OCLS = true end
 end
 SBT = bt//1

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
 
 -- Effect modifier timer mode and speed
 local emd = abs(EMDivider)
 if EMTimerMode == TTIME then
  EMT=t/1000/(2^emd)
 elseif EMTimerMode == TBEAT then
  EMT=(bt/(2^emd))%4
 elseif EMTimerMode == TBASS then
  EMT=BASS*5/(2^emd)
 elseif EMTimerMode == TBASSC then
  EMT=BASSC/50/(2^emd)
elseif EMTimerMode == TMID then
  EMT=MID*8/(2^emd)
 elseif EMTimerMode == TMIDC then
  EMT=MIDC/40/(2^emd)
elseif EMTimerMode == THIGH then
  EMT=HIGH*5/(2^emd)
 elseif EMTimerMode == THIGHC then
  EMT=HIGHC/100/(2^emd)
 else
  EMT=0
 end
 if EMDivider < 0 then
  EMT = -EMT
 end
 
 ModifierHandler(EOrder,0,EModifier, EMT,EMControl)

local effect = Effects[Effect]
effect.draw({t=t, et=ET, bt=bt, mid=MID, bass=BASS, bassc=BASSC})
 
 ModifierHandler(EOrder,1,EModifier, EMT,EMControl)

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

 -- overlay modifier timer mode and speed
 local omd = abs(OMDivider)
 if OMTimerMode == TTIME then
  OMT=t/1000/(2^omd)
 elseif OMTimerMode == TBEAT then
  OMT=(bt/(2^omd))%4
 elseif OMTimerMode == TBASS then
  OMT=BASS*5/(2^omd)
 elseif OMTimerMode == TBASSC then
  OMT=BASSC/50/(2^omd)
elseif OMTimerMode == TMID then
  OMT=MID*8/(2^omd)
 elseif OMTimerMode == TMIDC then
  OMT=MIDC/40/(2^omd)
elseif OMTimerMode == THIGH then
  OMT=HIGH*5/(2^omd)
 elseif OMTimerMode == THIGHC then
  OMT=HIGHC/100/(2^omd)
 else
  OMT=0
 end
 if OMDivider < 0 then
  OMT = -OMT
 end

 ModifierHandler(OOrder,0,OModifier, OMT,OMControl)

 if Overlay>0 then
  local Ov = Overlays[Overlay]
  Ov.draw({ot=OT})
 end

 ModifierHandler(OOrder,1,OModifier, OMT,OMControl)

 --[[if DEBUG == true then
  print("Effect: "..Effect.."|Ctrl: "..EControl.."|Timer: "..ETimerMode.."|Sped: "..EDivider.."|Pal: "..EPalette,0,100,12)
  print("EModifier: "..EModifier.."|Ctrl: "..EMControl.."|Timer: "..EMTimerMode.."|Sped: "..EMDivider.."|ET:"..ET,0,108,12)
  print("Overlay: "..Overlay.."|Ctrl: "..OControl.."|Timer: "..OTimerMode.."|Sped: "..ODivider.."|Pal: "..OPalette,0,116,12)
  print("OModifier: "..OModifier.."|Ctrl: "..OMControl.."|Timer: "..OMTimerMode.."|Sped: "..OMDivider,0,124,12)
 end--]]
 
 if DEBUG == true then
  print(EModifier.."|"..EMControl.."|"..EMTimerMode.."|"..EMDivider,0,100,12)
  print(Effect.."|"..EControl.."|"..ETimerMode.."|"..EDivider,0,108,12)
  print(Overlay.."|"..OControl.."|"..OTimerMode.."|"..ODivider,0,116,12)
  print(OModifier.."|"..OMControl.."|"..OMTimerMode.."|"..OMDivider,0,124,12)
 end

end

-- <TILES2>
-- 000:000000000000000000000000000000000cffffff0cffffff0cffffff0cffffff
-- 001:00000000000000000000000000000000ffffffffffffffffffffffffffffffff
-- 002:00000000000000000000000000000000ffffffffffffffffffffffffffffffff
-- 003:00000000000000000000000000000000ffffffffffffffffffffffffffffffff
-- 004:00000000000000000000000000000000ffffffffffffffffffffffffffffffff
-- 005:00000000000000000000000000000000ffffffffffffffffffffffffffffffff
-- 006:00000000000000000000000000000000ffffffffffffffffffffffffffffffff
-- 007:00000000000000000000000000000000fff10000fff10000fff10000fff10000
-- 016:0cffffff0cf000000c7000000c7000000c7000000c7000000c7000000c700000
-- 017:ffffffff00000000000000000000000000000000000000000000000000000000
-- 018:ffffffff00000000000000000000000000000000000000000000000000000000
-- 019:ffffffff00000000000000000000000000000000000000000000000000000000
-- 020:ffffffff00000000000000000000000000000000000000000000000000000000
-- 021:ffffffff00000000000000000000000000000000000000000000000000000000
-- 022:ffffffff00000000000000000000000000000000000000000000000000000000
-- 023:fff1000008f1000008f1000008f1000008f1000008f1000008f1000008f10000
-- 032:0c7000000c7000000c700ff10c700ff10c700ff30c700ff30c700ff70c700ff7
-- 033:00000000000000000000000f0000000f0000008f0000008f000000cf000000cf
-- 034:0000000000000000f008008ff008008ff00c108ff00c108ff00c308ff00e308f
-- 035:0000000000000000ff10cffffff30fffffff1cffffff78fffffff1fffffff3ef
-- 036:0000000000000000ffff7ef9ffff7ef1ffff7ef1ffff7ef1ffff7ef1ffff7ef1
-- 037:0000000000000000ff100cf7ff100cffff3008ffef7008ffcff000ffcff000ef
-- 038:0000000000000000cf000ff387000ff393008ff11300cff03000cf707000ef70
-- 039:08f1000008f1000008f1000008f1000008f1000008f1000008f1000008f10000
-- 048:0c700fff0c700fff0c700fff0c700fff0c700fff0c700fff0c700fff0c700fff
-- 049:000000ef000000ef100000ff100000ff300000ff300008ff700008ff70000cff
-- 050:f00e308ff00e708ff00f708ff00ff08ff08ff08ff08ff08ff08ff18ff0cff18f
-- 051:fffff7cfffffff00708fff10700eff107008ff307000ff307000ef707000cf70
-- 052:ffff7ef1ef300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1
-- 053:8ff100cf0ff300cf0ef3008f0ef7081f0cff083f08ff1c7e08ff1e7c00ff3ef8
-- 054:f000ff30f008ff10f108ff10f30cff00f30ef700f70ef300ff0ff300ff9ff100
-- 055:08f1000008f1000008f1000008f1000008f1000008f1000008f1000008f10000
-- 064:0c700fff0c700fff0c700fff0c700fff00000fff00000fff00000ffc00000ffc
-- 065:f0000cfff0000efff1000efff1000ffff3000ffff3008ffff3008f7ff700cf7f
-- 066:f0cff18ff0eff38ff0eff38ff0eff78ff0fff78ff0fff78ff0f7ff8ff8f7ef8f
-- 067:70008ff070008ff070008ff070000ff070000ff070000ff070000ff070000ff0
-- 068:cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1
-- 069:00ef7ff900effff100cffff0008ffff0000fff70000fff30000eff10000cff10
-- 070:ff9ff000fffff000efff7000efff3000cfff10008fff10000fff00000ff70000
-- 071:08f1000008f1000008f1000000f0000000000000000000000000000000000000
-- 080:00000ff800000ff800000ff000000ff000000ff00c700ff00c700ff00c700ff0
-- 081:f700cf3fff00ef3fff00ef1fff10ef1fef10ff0fef30ff0fcf38f70fcf78f70f
-- 082:f8f3ef9ffcf3ef9ffcf3cf1f7cf1cf3f7ef1cf3e3ef18f7e3ff08f7e3ff08f7c
-- 083:70000ff070000ff070000ff070000ff070000ff070000ff070008ff070008ff0
-- 084:cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1
-- 085:000cff00000eff10000eff30000fff70008fff70008ffff000cffff100effff1
-- 086:0ef700000fff00008fff00008fff1000cfff3000efff7000ffff7000fffff000
-- 087:000000000000000000000000000000000000000008f1000008f1000008f10000
-- 096:0c700ff00c700ff00c700ff00c700ff00c700ff00c700ff00c700ff00c700ff0
-- 097:8f7cf30f8ffcf30f0ffef10f0ffff10f0efff00f0efff0070cff70070cff7007
-- 098:1f700ffc9f700ffc8f700ef9cf300ef9cf300ef1cf300cf3ef100cf3ef100cf3
-- 099:7000cf707000cf707000ef707000ff30700cff10700fff1078ffff00effff700
-- 100:cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1
-- 101:00ff3ff300ff3ef708ff1cff0cff0cff0cf708ff0ef700ff0ff300ef8ff100ef
-- 102:ef9ff100ef0ff300c70ff300870ef700130cff00310cff003008ff107000ff30
-- 103:08f1000008f1000008f1000008f1000008f1000008f1000008f1000008f10000
-- 112:0c700ff00c700ff00c700ff00c700ff00c700ff00c700ff00c7000000c700000
-- 113:08ff300300ff300300ff100100ef100900000008000000080000000000000000
-- 114:ef1008f7ff0008f7ff0008ffff0000fff70000fff70000ff0000000000000000
-- 115:effff300cffff100cfff7000cfff10008ff700009f7000000000000000000000
-- 116:cf300ef1cf300ef1cf300ef1cf300ef1cf300ef1cf300ef90000000000000000
-- 117:8ff100cfcff0008fef70009fef30083fff300c3eff100c7c0000000000000000
-- 118:f000ef70f100ef70f100cff0f3008ff1f7000ff1f7000ff30000000000000000
-- 119:08f1000008f1000008f1000008f1000008f1000008f1000008f1000008f10000
-- 128:0c7000000c7000000c7000000c7000000c7000000c7000000c7000000cffffff
-- 129:00000000000000000000000000000000000000000000000000000000ffffffff
-- 130:00000000000000000000000000000000000000000000000000000000ffffffff
-- 131:00000000000000000000000000000000000000000000000000000000ffffffff
-- 132:00000000000000000000000000000000000000000000000000000000ffffffff
-- 133:00000000000000000000000000000000000000000000000000000000ffffffff
-- 134:00000000000000000000000000000000000000000000000000000000ffffffff
-- 135:08f1000008f1000008f1000008f1000008f1000008f1000008f10000fff10000
-- 144:0cffffff0cffffff0cffffff0cffffff00000000000000000000000000000000
-- 145:ffffffffffffffffffffffffffffffff00000000000000000000000000000000
-- 146:ffffffffffffffffffffffffffffffff00000000000000000000000000000000
-- 147:ffffffffffffffffffffffffffffffff00000000000000000000000000000000
-- 148:ffffffffffffffffffffffffffffffff00000000000000000000000000000000
-- 149:ffffffffffffffffffffffffffffffff00000000000000000000000000000000
-- 150:ffffffffffffffffffffffffffffffff00000000000000000000000000000000
-- 151:fff10000fff10000fff10000fff1000000000000000000000000000000000000
-- </TILES2>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

