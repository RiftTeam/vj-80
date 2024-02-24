-- title:  goto80 lovebyte2024
-- author: mantratronic + ps
-- desc:   vj80
-- script: lua

package.path=package.path..";C:\\Users\\micro\\AppData\\Roaming\\com.nesbox.tic\\TIC-80\\mantratronic-vj-80\\?.lua"	-- jtruk

--local GigSetup=require("gig/20240210-lovebyte-ps-goto80")
local GigSetup=require("gig/jtruk-debug")

require("code/math")
require("code/draw")
require("code/palette")
require("code/globals")
require("code/gig")
require("code/state")
require("code/scn")
require("debug/fakefft")
bootFont=require("code/font")

local TicFn = nil

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

SCN0=nil
SCN1=nil

function FFT_BOOT()
	for i=0,255 do
		FFTH[i]=0
		FFTC[i]=0
	end
end

function FFT_FILL()
	for i=0,239 do
		local f=fft(i)*Loudness
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

-- Keyboard Control

Effect=1
Overlay=0
EModifier=0
OModifier=0
Loudness=1
ECLS=true
OCLS=true

OOrder = 0
EOrder = 0

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

-- Time Modes
TM_NONE=0
TM_TIME=1
TM_BEAT=2
TM_BASS=3
TM_BASSC=4
TM_MID=5
TM_MIDC=6
TM_HIGH=7
TM_HIGHC=8
TM_MAX = TM_HIGHC

DEBUG=true

-- Modifiers

function DrawModifier(iModifier, control, params, t)
	local modifier = getModifierByIndex(iModifier)
	if modifier ~= nil then
		modifier.draw(1000*HIGH, control, params, t)
	end
end

TImages={}

-- TestSheet
TestSheetPAL={}
function TestSheet_BOOT()
 TestSheetPAL=makePalette3(0,0,0,255,30,0,255,255,255)
 --TestSheetPAL=makePalette2(0,0,0,255,255,255)
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
		if keyp(17) then
			Effect = 1
			EControl = 1
			ETimerMode= 0
			EDivider = 1
			EPalette = 1
		end

		-- 1: effect mod
		if keyp(28) then
			EModifier=0
			EMControl = 1
			EMTimerMode = 0
			EMDivider = 1
			EStutter = 0
			ECLS=true
		end

		-- a: overlay
		if keyp(1) then
			Overlay = 1
			OControl = 1
			OTimerMode = 0
			ODivider = 1
			OPalette = 1
		end

		-- z: overlay modifier
		if keyp(26) then
			OModifier = 0
			OMControl = 1
			OMTimerMode = 0
			OMDivider = 1
			OStutter = 0
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

		-- #TODO: sure there's better :)
		for keycode = 27,36 do
			if keyp(keycode) then
				triggerNumberShortcut(keycode-27)
			end
		end

		-- left: increase 3d logo
		-- right: decrease 3d logo
		-- This is for Fuji-Twist effect
		-- #TODO: put this back in...
		-- OL_ID = OL_ID + (keyp(60) and 1 or 0) + (keyp(61) and -1 or 0)

		-- #TODO: put this back in...
		--  OL_ID = clamp(OL_ID%(#OldLogos+1),1,#OldLogos)

		-- home: FFTH_length up by 1
		-- end: FFTH_length down by 1
		FFTH_length = clamp(FFTH_length + (keyp(56) and 1 or 0) + (keyp(57) and -1 or 0), 2, 60)

		-- insert: stutter effect cls switch
		if keyp(53) then
			EStutter = 1 - EStutter -- 0 <-> 1
		end

		-- delete: stutter overlay cls switch
		if keyp(52) then
			OStutter = 1 - OStutter -- 0 <-> 1
		end

		return
	end

	-- Beat detection/input
	if keyp(48,10000,10) then
		local currentbeat=clamp((BTC+1)%BEATS,1,BEATS)
		BTA[currentbeat]= time()-LBT
		LBT=T
		BTC=currentbeat
		local beatssum = 0
		for i=1,BEATS do
			beatssum=beatssum+BTA[i]
		end
		BT=beatssum/BEATS
	end 

	-- home: Loudness up by 0.1
	-- end: Loudness down by 0.1
	Loudness = clamp(Loudness + (keyp(56) and 0.1 or 0) + (keyp(57) and -0.1 or 0), 0.1, 10)

	-- #TODO: Look at texts

	-- up: increase text image
	-- down: decrease text image
--	TIimageID = TIimageID + (keyp(58) and 1 or 0) + (keyp(59) and -1 or 0)
-- 	TIimageID = clamp(TIimageID%(#TImages+1),1,#TImages)

	-- left: decrease text image
	-- right: increase text image
--	TextID = TextID + (keyp(60) and -1 or 0) + (keyp(61) and 1 or 0)
-- 	TextID = clamp(TextID%(#Texts+1),1,#Texts)
  
	-- insert: effect cls switch
	if keyp(53) then
		ECLS = not ECLS
	end

	-- pageup: effect modifier order switch
	if keyp(54) then
		EOrder = 1 - EOrder -- 0 <-> 1
	end

	-- q: effect down
	-- w: effect up
	Effect = Effect + (keyp(17) and -1 or 0) + (keyp(23) and 1 or 0)
	Effect = clamp(Effect, 1, getEffectCount())

	-- TODO: key instead of keyp? limit?
	-- e: effect control down
	-- r: effect control up
	EControl = EControl + (keyp(5) and -1 or 0) + (keyp(18) and 1 or 0)

	-- t: effect timer down
	-- y: effect timer up
	ETimerMode = clamp(ETimerMode + (keyp(20) and -1 or 0) + (keyp(25) and 1 or 0), 0, TM_MAX)

	-- u: effect divider down
	-- i: effect divider up
	EDivider = clamp(EDivider + (keyp(21) and -1 or 0) + (keyp(9) and 1 or 0), -10, 10)

	-- o: effect palette down
	-- p: effect palette up
	local oldPalette = EPalette
	EPalette = (EPalette + (keyp(15) and -1 or 0) + (keyp(16) and 1 or 0)) % getPaletteCount()
	if oldPalette ~= EPalette then
		SCN0:setPalette(getPaletteByIndex(EPalette))
	end
	
	-- 1: effect modifier down
	-- 2: effect modifier up
	EModifier = (EModifier + (keyp(28) and -1 or 0) + (keyp(29) and 1 or 0)) % (getModifierCount()+1)

	-- 3: effect modifier control down
	-- 4: effect modifier control up
	EMControl = EMControl + (keyp(30) and -1 or 0) + (keyp(31) and 1 or 0)

	-- 5: effect modifier timer down
	-- 6: effect modifier timer up
	EMTimerMode = clamp(EMTimerMode + (keyp(32) and -1 or 0) + (keyp(33) and 1 or 0), 0, TM_MAX)

	-- 7: effect modifier divider down
	-- 8: effect modifier divider up
	EMDivider = clamp(EMDivider + (keyp(34) and -1 or 0) + (keyp(35) and 1 or 0), -10, 10)

	-- z: overlay modifier down
	-- x: overlay modifier up
	OModifier = (OModifier + (keyp(26) and -1 or 0) + (keyp(24) and 1 or 0)) % (getModifierCount()+1)

	-- c: overlay modifier control down
	-- v: overlay modifier control up
	OMControl = OMControl + (keyp(3) and -1 or 0) + (keyp(22) and 1 or 0)

	-- b: overlay modifier timer down
	-- n: effect modifier timer up
	OMTimerMode = clamp(OMTimerMode + (keyp(2) and -1 or 0) + (keyp(14) and 1 or 0), 0, TM_MAX)
  
	-- m: overlay modifier divider down
	-- ,: overlay modifier divider up
	OMDivider = clamp(OMDivider + (keyp(13) and -1 or 0) + (keyp(45) and 1 or 0), -10, 10)

	-- a: effect down
	-- s: effect up
	Overlay = (Overlay + (keyp(1) and -1 or 0) + (keyp(19) and 1 or 0)) % (getOverlayCount()+1)
  
	-- TODO: key instead of keyp? limit?
	-- d: overlay control down
	-- f: overlay control up
	OControl = OControl + (keyp(4) and -1 or 0) + (keyp(6) and 1 or 0)

	-- g: overlay timer down
	-- h: overlay timer up
	OTimerMode = clamp(OTimerMode + (keyp(7) and -1 or 0) + (keyp(8) and 1 or 0), 0, TM_MAX)

	-- j: overlay divider down
	-- k: overlay divider up
	ODivider = clamp(ODivider + (keyp(10) and -1 or 0) + (keyp(11) and 1 or 0), -10, 10)

	-- l: overlay palette down
	-- ;: overlay palette up
	local oldPalette = OPalette
	OPalette = (OPalette + (keyp(12) and -1 or 0) + (keyp(42) and 1 or 0)) % getPaletteCount()
	if oldPalette ~= OPalette then
		SCN1:setPalette(getPaletteByIndex(OPalette))
	end

	-- delete: overlay cls switch
	if keyp(52) then
		OCLS = not OCLS	-- false <-> true
	end

	-- pagedown: effect modifier order switch
	if keyp(55) then
		OOrder = 1 - OOrder -- 0 <-> 1
	end

	-- backslash: debug switch
	if keyp(49) then
		cls()
		DEBUG = not DEBUG	-- false <-> true
	end

	-- backspace: exit
	--if keyp(51) then
	-- exit()
	--end
end

function SCN(y)
	vbank(0)
	if SCN0 then
		local scn=SCN0:get(y)
		for i,c in pairs(scn.rgbs) do
			poke(16320+i,c)
		end
	end

	vbank(1)
	
	if SCN1 then
		local scn=SCN1:get(y)
		for i,c in pairs(scn.rgbs) do
			poke(16320+i,c)
		end
	end
end

function BOOT()
	bootFont()

	FFT_BOOT()
	BEATTIME_BOOT()

	-- We can override avaliable effects, overlays, and modifiers
	-- And also set up our number shortcuts
	GigSetup.boot()

	bootEffects()
	bootOverlays()
	bootModifiers()
	bootPalettes()

	SCN0 = Scn:new(getPaletteByIndex(EPalette))
	SCN1 = Scn:new(getPaletteByIndex(OPalette))
	
	TicFn = TICstartup
end

function TICstartup()
	cls()
	print("VJ80",105,0,12)

	if keyp(48) then
		TicFn = TICvj
	end

	for i,id in ipairs(getEffectIDs()) do
		print(id,0,8+i*6,13,false,1,true)
	end

	for i,id in ipairs(getOverlayIDs()) do
		print(id,60,8+i*6,13,false,1,true)
	end

	for i,id in ipairs(getModifierIDs()) do
		print(id,120,8+i*6,13,false,1,true)
	end

	for i,id in ipairs(getPaletteIDs()) do
		print(id,180,8+i*6,13,false,1,true)
	end

	print("Space to start", 80,128,12)
end

T=0
function TICvj()
	poke(0x3ffb,4)	-- remove mouse pointer but doesn't
	
	T=time()

	local bt=((T-LBT))/(BT)
	if EStutter == 1 and SBT ~= bt//1 then
		ECLS = not ECLS
	end

	if OStutter == 1 and SBT ~= bt//1 then
		OCLS = not OCLS
	end

	SBT = bt//1
 
	FFT_FILL()
	KEY_CHECK()

	local params = {
		t=T,
		bt=bt,
		bass=BASS,
		bassc=BASSC,
		mid=MID,
		midc=MIDC,
		high=HIGH,
		highc=HIGHC,
		fftc=FFTC,
		ffth=FFTH,

		oDivider=ODivider,	-- Used for one overlay - should it stay? #TODO
	}
	local et = getT(ETimerMode, EDivider, params)	-- effect timer
 	local emt = getT(EMTimerMode, EMDivider, params) -- effect modifier timer
	local ot = getT(OTimerMode, ODivider, params) -- overlay timer
	local omt = getT(OMTimerMode, OMDivider, params) -- overlay modifier timer
 
	vbank(0)
	if ECLS then 
		cls()
	end

	if EOrder == 0 then
		DrawModifier(EModifier, EMControl, params, emt)
	end

	local effect = getEffectByIndex(Effect)
	if effect then
		effect.draw(EControl, params, et)
	end
 
	if EOrder == 1 then
		DrawModifier(EModifier, EMControl, params, emt)
	end

	vbank(1)
	if OCLS then 
		cls()
	end
 
	if OOrder == 0 then
		DrawModifier(OModifier, OMControl, params, omt)
	end

	if Overlay > 0 then
		local overlay = getOverlayByIndex(Overlay)
		if overlay then
			overlay.draw(OControl, params, ot)
		end
	end

	if OOrder == 1 then
		DrawModifier(OModifier, OMControl, params, omt)
	end
 
	if DEBUG then
		rect(4,94,180,40,15)
		if EModifier >= 1 then
			print(getModifierIDByIndex(EModifier).."|"..EMControl.."|"..EMTimerMode.."|"..EMDivider.."|"..EStutter,6,96,12)
		end
		print(getEffectIDByIndex(Effect).."|"..EControl.."|"..ETimerMode.."|"..EDivider.."|"..getPaletteIDByIndex(EPalette),6,104,12)
		if Overlay >= 1 then
			print(getOverlayIDByIndex(Overlay).."|"..OControl.."|"..OTimerMode.."|"..ODivider.."|"..getPaletteIDByIndex(OPalette),6,112,12)
		end
		if OModifier >= 1 then
			print(getModifierIDByIndex(OModifier).."|"..OMControl.."|"..OMTimerMode.."|"..OMDivider.."|"..OStutter,6,120,12)
		end
		print((ECLS and 1 or 0).."|"..(OCLS and 1 or 0).."|"..FFTH_length.."|"..Loudness,6,128,12)
	end

	SCN0:update(T/BT)
	SCN1:update(T/BT)
end

-- pos to add Beat% and Volume (all ffth)
function getT(timerMode, divider, params)
	local divPow=2^abs(divider)
	local t=0
	if timerMode == TM_TIME then
		t = (params.t/1000)/divPow
	elseif timerMode == TM_BEAT then
		t = (params.bt/divPow)%4
	elseif timerMode == TM_BASS then
		t = (params.bass*5)/divPow
	elseif timerMode == TM_BASSC then
		t = (params.bassc/50)/divPow
	elseif timerMode == TM_MID then
		t = (params.mid*8)/divPow
	elseif timerMode == TM_MIDC then
		t = (params.midc/40)/divPow
	elseif timerMode == TM_HIGH then
		t = (params.high*5)/divPow
	elseif timerMode == TM_HIGHC then
		t = (params.highc/100)/divPow
	end

	return divider < 0 and -t or t
end

function TIC()
	if TicFn then
		TicFn()
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

