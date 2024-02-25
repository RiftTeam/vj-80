-- title:  goto80 lovebyte2024
-- author: mantratronic + ps
-- desc:   vj80
-- script: lua

package.path=package.path..";C:\\Users\\micro\\AppData\\Roaming\\com.nesbox.tic\\TIC-80\\mantratronic-vj-80\\?.lua"	-- jtruk

local GigSetup=require("gig/20240210-lovebyte-ps-goto80")
--local GigSetup=require("gig/jtruk-debug")

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
	local et = getBeatT(ETimerMode, EDivider, params)	-- effect timer
 	local emt = getBeatT(EMTimerMode, EMDivider, params) -- effect modifier timer
	local ot = getBeatT(OTimerMode, ODivider, params) -- overlay timer
	local omt = getBeatT(OMTimerMode, OMDivider, params) -- overlay modifier timer
 
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
function getBeatT(timerMode, divider, params)
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

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

