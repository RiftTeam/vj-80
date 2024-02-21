-- Assembled by the RiFT bundler

rift_codestate=function()
function setEffect(id, config)
    Effect = EffectsLookup[id]
    ETimerMode = config.timerMode
    EDivider = config.divider
    EPalette = config.palette
    EStutter = config.stutter
    EModifier = config.modifier
    EMControl = config.modControl
    EMTimerMode = config.modTimerMode
    EMDivider = config.modDivider
    ECLS = config.cls
  end
  
  function setOverlay(id, config)
    Overlay = OverlaysLookup[id]
    OTimerMode = config.timerMode
    ODivider = config.divider
    OControl = config.control
    OPalette = config.palette
    OStutter = config.stutter
    OModifier = config.modifier
    OCLS = config.cls
  end
  
  SHORTCUTS={}
  function setNumberShortcut(number, fn)
    SHORTCUTS[number] = fn
  end
  
  function triggerNumberShortcut(number)
    if SHORTCUTS[number] ~= nil then
      SHORTCUTS[number]()
    end
  end

--[[
    Something like this might be useful?
EffectState={}
OverlayState={}
State={}

function EffectState:new()
    local o={
        id=nil,
        timerMode=nil,
        divider=nil,
        control=nil,
        palette=nil,
        modifier=nil,
        modTimerMode=nil,
        modDivider=nil,
        stutter=nil,
        cls=nil,
    },

    setmetatable(o,self)
    self.__index=self
    return o
end

function OverlayState:new()
    local o={
        id=nil,
        timerMode=nil,
        divider=nil,
        control=nil,
        palette=nil,
        modifier=nil,
--        modTimerMode=nil,
--        modDivider=nil,
        stutter=nil,
        cls=nil,
    },

    setmetatable(o,self)
    self.__index=self
    return o
end


function State:new(effectState, overlayState)
    local o={
        effect=effectState,
        overlay=overlayState,
    }

    setmetatable(o,self)
    self.__index=self
    return o
end
--]]

end

rift_paletteslowwhite=function()
-- was: palette index 9

local palette = {}

return {
	id="slow_white",
	boot=function()
	end,
	get=function(y, t)
		local it=t
		local ta=96*(sin(it/10)+1)
		local tb=96*(sin(it/10+tau/3)+1)
		local tc=96*(sin(it/10+tau*4/3)+1)
		local rgbs = {}
		for i=0,7 do
			rgbs[i*3] = (i/7*(ta))
			rgbs[i*3+1] = (i/7*(tb))
			rgbs[i*3+2] = (i/7*(tc))
		end
		for i=8,15 do
			rgbs[i*3] = min(255,(15-i)/7*ta + (i-7)/8*255)
			rgbs[i*3+1] = min(255,(15-i)/7*tb + (i-7)/8*255)
			rgbs[i*3+2] = min(255,(15-i)/7*tc + (i-7)/8*255)
		end
		return rgbs
	end,
}

end

rift_gig20240210lovebytepsgoto80=function()
return {
	-- #TODO: This might get renamed...
	boot=function()
		setTexts({
			{"LOVEBYTE","2024","+ + +","GOTO80","+ + +"},
			{"ACID","DANCE","ROBOT","NINJA"},
			{"LOVE","LIFE","LIVE","LEFT","LOUD","LINE"},
			{"MATH","SINE","CIRC","LINE","CLS","RECT"},
			{"MUNCH","---"},
			{"I","DONT","KNOW"},
			{"SHALALA","---"},
			{"HARDCORE","FAMILY"},
			{"BREAK","BEAT","DANCE","HIT","HOP","SHOUT","SCREAM","JUMP"},
		})

		--[[
		setEffects({
			'vol_test', 'twist_fft', 'sun_beat', 'fuji_twist', 'at_tunnel', 'quup', 'tunnel_wall', 'cloud_tunnel',
			'swirl_tunnel', 'chladni', 'circle_column', 'broken_egg', 'para_flower', 'fft_circ', 'proxima', 'lemons',
			'revision_back'
		})

		setOverlays({
			'text_bounce_up', 'smiley_faces', 'text_warp', 'snow', 'smoke_circles', 'spiral', 'bobs', 'joy_division',
			'line_cut', 'sticker_lens', 'revision_top', 'revision_logo', 'madtixx_logo',
		})

		setModifiers({
			'pix_noise', 'pix_zoom', 'grid_dim',	'post_circ', 'pix_motion_blur', 'pix_motion_blur',
			'pix_jump_blur', 'rot_vert',	'rot_horz', 'sft_vert', 'sft_horz', 'post_squares',
		})
		--]]

		setNumberShortcut(1, function()
			setEffect('sun_beat', {timerMode=3, divider=1, palette='reddish', stutter=0, modifier=0, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('smoke_circles', {timerMode=1, divider=1, palette='eire', control=2, stutter=0, modifier=1, cls=false})
		end)

		setNumberShortcut(2, function()
			setEffect('lemons', {timerMode=1, divider=1, palette=5, stutter=0, modifier=5, modControl=1, modTimerMode=1, modDivider=1, cls=true})
			setOverlay('text_warp', {timerMode=4, divider=6, palette=7, control=13, stutter=0, modifier=5, cls=true})
		end)

		setNumberShortcut(3, function()
			setEffect('twist_fft', {timerMode=1, divider=1, palette=7, stutter=0, modifier=6, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('text_bounce_up', {timerMode=1, divider=1, palette=5, control=2, stutter=0, modifier=7, cls=true})
		end)

		setNumberShortcut(4, function()
			setEffect('quup', {timerMode=1, divider=1, palette='reddish', stutter=0, modifier=11, modControl=33, modTimerMode=4, modDivider=1, cls=false})
			setOverlay('bobs', {timerMode=1, divider=1, palette=6, control=2, stutter=0, modifier=11, cls=false})
		end)

		setNumberShortcut(5, function()
			setEffect('at_tunnel', {timerMode=1, divider=1, palette='sweetie_16', stutter=0, modifier=13, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('spiral', {timerMode=2, divider=6, palette=10, control=3, stutter=0, modifier=13, cls=false})
		end)

		setNumberShortcut(6, function()
			setEffect('worms', {timerMode=2, divider=5, palette='over_brown', stutter=0, modifier=12, modControl=1, modTimerMode=1, modDivider=1, cls=true})
			setOverlay('line_cut', {timerMode=1, divider=1, palette='ukr', control=1, stutter=0, modifier=2, cls=true})
		end)

		setNumberShortcut(7, function()
			setEffect('quup', {timerMode=2, divider=1, palette='ukr', stutter=0, modifier=11, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('smiley_faces', {timerMode=1, divider=1, palette=7, control=15, stutter=0, modifier=2, cls=true})
		end)

		setNumberShortcut(8, function()
			setEffect('bitnick', {timerMode=1, divider=1, palette='over_brown', stutter=0, modifier=12, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('sinebobs', {timerMode=3, divider=5, palette=9, control=1, stutter=0, modifier=6, cls=true})
		end)

		setNumberShortcut(9, function()
			setEffect('at_tunnel', {timerMode=5, divider=3, palette='grey_scale', stutter=0, modifier=13, modControl=1, modTimerMode=1, modDivider=1, cls=true})
			setOverlay('bobs', {timerMode=1, divider=1, palette='eire', control=1, stutter=0, modifier=12, cls=false})
		end)

		setNumberShortcut(0, function()
			setEffect('worms', {timerMode=1, divider=1, palette=7, stutter=0, modifier=7, modControl=0, modTimerMode=3, modDivider=0, cls=false})
			setOverlay('sticker_lens', {timerMode=3, divider=1, palette=5, control=1, stutter=0, modifier=13, cls=true})
		end)
	end,
}

-- #TODO: I don't think this one made it...
--  setEffect('revision_back', {timerMode=5, divider=6, palette=1, stutter=0, modifier=3, modControl=1, modTimerMode=1, modDivider=1, cls=false})
--  setOverlay('bobs', {timerMode=8, divider=0, palette=13, control=4, stutter=0, modifier=1, cls=true})

end

rift_effectworms=function()
-- was: effect index = 18
return {
    id='worms',
    boot=function()
    end,

	draw=function(control, params, t)
        for p=0,14,.01 do
	        circ(
				120+sin(p+t/3)*(p*6-8+sin(t)*20),
				68+sin(p+t+1)*(p*3-8+sin(t)*10),
				abs(sin(p+t)*p*2.5),
				p*17%8
			)
        end
    end,
}

end

rift_modifierpixjumpblur=function()
-- Was: modifier index = 6

return {
	id='pix_jump_blur',
	draw=function(amount, control, params, t)
		local size = 10+t%5
		local limit = 100 + control
		local cx,cy=120, 68
		local tt = params.bass%1
		for i=0,tt*50 do
			local d=rand()
			d=1-(d^1.5)
			local d1=size+d*(limit-tt*10)
			local d2=1+d1+tt*10
			local a=rand()*tau
			local x,y=d1*sin(a),d1*cos(a)
			line(cx+(d1)*sin(a),cy+(d1)*cos(a),cx+(d2)*sin(a),cy+(d2)*cos(a),pix(cx+x,cy+y))
		end

		amount = min(amount,500)
		for i=0,amount do
			local d=rand()
			d=1-(d^1.5)
			d=d*(size//1+limit*1.5)
			local a=rand()*tau
			local x,y=cx+d*sin(a),cy+d*cos(a)
			if x >= 1 and x <= 239 and y >=1 and y <= 134 then
				pix(cx+(d+1)*sin(a),cy+(d+1)*cos(a),clamp((pix(x,y)+pix(x+1,y+1)+pix(x+1,y-1)+pix(x-1,y+1)+pix(x-1,y-1))/4.8,0,15))
			end
		end
	end,
}

end

rift_effectfujitwist=function()
-- was: effect index = 3

-- #TODO: Patch this in :)

local Fuji_lines = {}
local Fuji_drawlines = {}
local Fuji_frames = {}
local Fuji_width=16
local Fuji_height=120
local Fuji_numframes=240
local OldLogos={}
local OL_ID=1

return {
  id='fuji_twist',
  boot=function()
    for y=1,Fuji_height do
      bend= 1.5*Fuji_width*exp((y/Fuji_height)^2)--+w/5
       
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
  end,

  draw=function(control, params, t)
	-- TODO: separate by lines for faster draw
    local it,ifft=data.et,data.mid
    bnc=sin(ifft)*10
    frames = OldLogos[OL_ID]
    for y=1,Fuji_height do
      twist=Fuji_numframes*(1+it+BASS*EControl*cos(y/Fuji_height))/2
      dl=frames[twist//1%Fuji_numframes+1]
      for i=1,#dl do
        ln=dl[i]
        if ln[2] == y then  
          line(120+ln[1],ln[2]+bnc,120+ln[3],ln[4]+bnc,ln[5])
        end
      end
    end
  end,
  bdr=function(l)
    ftt=BASSC/100
    grader=sin(ftt*11/5+l/30)+1
    gradeg=sin(ftt*11/3+l/30)+1
    gradeb=sin(ftt*11/2+l/30)+1
    for i=0,15 do
     poke(0x3fc0+i*3,  clamp(i*16*(grader),0,255))
     poke(0x3fc0+i*3+1,clamp(i*16*(gradeg),0,255))
     poke(0x3fc0+i*3+2,clamp(i*16*(gradeb),0,255))
    end
  end,
}

--[[
  #TODO: Add back in...
OL_lines = {}
OL_drawlines = {}
OL_frames = {}
OL_width=16
OL_height=120
OL_numframes=240

function OL_scan(ilines)
  OL_drawlines={}
  OL_frames={}
  for j=1,OL_numframes do
    OL_drawlines={}
   a=j/OL_numframes*tau
   for i=1,#ilines do
    ln=ilines[i]
    cx=ln.cx
    cy=ln.cy
    x1=cx-ln.r/2
    x2=cx+ln.r/2
    z1=-OL_width/2
    z2=OL_width/2
    
    a1=sin(a-tau/8)
    a2=sin(a+tau/8)
    a3=sin(a+tau*3/8)
    a4=sin(a-tau*3/8)
 
    X1=x1*cos(a)-z2*sin(a)
    Z1=x1*sin(a)+z2*cos(a)
    X2=x1*cos(a)-z1*sin(a)
    Z2=x1*sin(a)+z1*cos(a)
    X3=x2*cos(a)-z1*sin(a)
    Z3=x2*sin(a)+z1*cos(a)
    X4=x2*cos(a)-z2*sin(a)
    Z4=x2*sin(a)+z2*cos(a)
    if(X1 < X2) then
     c=(1-(abs(a%tau-tau/4)/tau))*15
     table.insert(OL_drawlines,{X1,cy,X2,cy,c,(Z1+Z2)/2})
    end
    if(X2 < X3) then
     c=(1-(abs(a%tau-tau/2)/tau))*15
     table.insert(OL_drawlines,{X2,cy,X3,cy,c,(Z2+Z3)/2})
    end
    if(X3 < X4) then
     c=(1-(abs(a%tau-tau*3/4)/tau))*15
     table.insert(OL_drawlines,{X3,cy,X4,cy,c,(Z3+Z4)/2})
    end
    if(X4 < X1) then
     c=(1-((abs(a%tau-tau/2))/tau))*15
     table.insert(OL_drawlines,{X4,cy,X1,cy,c,(Z4+Z1)/2})
    end
   end
   table.sort(OL_drawlines, function (a,b) return a[6] < b[6] end)
   OL_frames[j]=OL_drawlines
  end

  table.insert(OldLogos,OL_frames)
end

function vectrex_BOOT()
  vec_lines={}
  cls()
  for y=10,Fuji_height-10 do
    line(230-y,y,10+y,y,1)
  end
  for y=10,Fuji_height-40 do
    line(30+y,y,30+Fuji_width+y,y,0)
  end
  for y=1,Fuji_height do
    -- fuck it search by image
    c=1
    for x=0,240 do
     if c==1 and pix(x,y) == 1 then
      c1=x
      c=2
     elseif c==2 and pix(x,y) == 0 then
      c2=x
       
      r=c1-c2
      l={cx=r/2+x-120, cy=y+10, r=r}
      table.insert(vec_lines,l)
      c=1
     end
    end
  end
  OL_scan(vec_lines)
end

function amiga_BOOT()
  amiga_lines={}
  cls()
  for y=10,Fuji_height-10 do
    line(200-y,y,200+Fuji_width-y,y,1)

    line(177-y,y,177+Fuji_width-y,y,1)
  end

  i=0
  for y=Fuji_height-10,Fuji_height-50,-1 do
    i=i+2
    line(177-y-i,y,177-y-i+Fuji_width,y,1)

    line(200-y-i,y,200-y-i+Fuji_width,y,1)
  end
  for y=1,Fuji_height do
    -- fuck it search by image
    --space=136-Fuji_height
    c=1
    for x=0,240 do
     if c==1 and pix(x,y) == 1 then
      c1=x
      c=2
     elseif c==2 and pix(x,y) == 0 then
      c2=x
       
      r=c1-c2
      l={cx=r/2+x-120, cy=y+10, r=r}
      table.insert(amiga_lines,l)
      c=1
     end
    end
  end
    OL_scan(amiga_lines)

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

  OL_scan(c64_lines)
 end
 --]]

end

rift_modifierpixnoise=function()
-- Was: modifier index = 1

return {
    id='pix_noise',
    draw=function(amount, control, params, t)
        for i=0,amount do
            x, y=rand(240)-1,rand(136)-1
            pix(x,y,clamp(pix(x,y)-control,0,15))
        end
    end,
}

end

rift_effectchladni=function()
-- was: effect index = 9
local ChN=2000
local ChNP=3
local ChV=0.5
local ChPV=-.2
local Chd=1
local ChPX={}
local ChPY={}
local ChT=0 
local ChTT=0
local ChPTX={}
local ChPTY={}
local Chfreq=.75
local ChNPKD = 15

function ChResetPoints(t)
	for i=1,ChNP do
		ChPTX[i]=120-ChNPKD/2+ChNPKD*i/3+30*sin(t/20+ i/ChNP * 2 * pi)
		ChPTY[i]=68-ChNPKD/2+ChNPKD*i/3+26*cos(t/20+i/ChNP * 2 * pi)
	end
end

return {
	id='chladni',
	boot=function()
		ChResetPoints(0)
		for i=1,ChN do
			ChPX[i] = rand(240);
			ChPY[i] = rand(136);
		end
	end,
	draw = function(control, params, t)
		ChT = t--ChT+.2
		ChTT = (t*10)//1--ChTT+1
		ChResetPoints(t)

		if ChTT%100 == 0 then
			ChNP = 3 + control*rand()
			Chfreq = .3 + rand()
			ChNPKD = 10 + 30*rand()
			Chladni_BOOT()
		end

		for i=1,ChN do
			local R=0
			local D=0
			local C=0
			for j=1,ChNP do
				local sx,sy = ChPTX[j], ChPTY[j]

				local L=sqrt((ChPX[i]-sx)^2 + (ChPY[i]-sy)^2)
				C=C + sin(tau*Chfreq*(ChT-(L/ChV))/60)

				local d=0	-- #TODO: Check what this should be!
				L=sqrt((ChPX[i]+d-sx)^2 + (ChPY[i]-sy)^2)
				R=R + sin(tau*Chfreq*(ChT-(L/ChV))/60)

				L=sqrt((ChPX[i]-sx)^2 + (ChPY[i]+Chd-sy)^2)
				D=D + sin(tau*Chfreq*(ChT-(L/ChV))/60)
			end
			C=abs(C)
			R=abs(R)
			D=abs(D)

			circ(ChPX[i],ChPY[i],4-C*2,(1.5-C)*10)

			L=sqrt((R-C)^2 + (D-C)^2)

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
	end,
}

end

rift_effectproxima=function()
-- was: effect index = 14

PR_p={}
PR_np=127
PR_tc=0

return {
	id='proxima',
	boot=function()
		for i=0,PR_np do
			PR_p[i]={x=rand(240.0),y=rand(136.0),sx=rand(10.0)-5,sy=rand(10.0)-5}
		end
	end,
	draw=function(control, params, t)
		local n = 255//PR_np

		local q={}
		for i=0,PR_np do
			local v=PR_p[i]
			v.x=(v.x+v.sx/5*sin(i/10+t)*t)%240
			v.y=(v.y+v.sy/8*sin(i/11+t)*t)%136
			q[i]=v
		end

		--table.sort(q, function (a,b) return a.x < b.x end)

		local ffth = params.ffth
		for i=0,PR_np do
			local v=q[i]
			local fi=ffth[i]*(.15+i/60) * control
			pix(v.x,v.y,fi*500)

			for j=i,PR_np do
				local w=q[j]
				local d=(v.x-w.x)^2 + (v.y-w.y)^2
				d=d^.5
				n=(i+j)/2
				local fj=ffth[j]*(.15+j/60) * control
				local ft = (fi + fj)

				if d < ft * 100 and i ~= j then
					line(v.x,v.y,w.x,w.y,ft*100)
					for l=j,PR_np do
						local z=q[l] -- q?  
						d=(v.x-z.x)^2 + (v.y-z.y)^2
						d=d^.5
						local fl = ffth[l]*(.15+l/60) * control
						local ft = fi + fj + fl
						if d < ft * 25 and l ~= j and l ~= i then
							tri(v.x,v.y,w.x,w.y,z.x,z.y,ft*100)
							goto continue
						end
					end
				end
			end
			::continue::
		end
	end,
}

end

rift_modifierlinescratch=function()
-- Was: modifier index = 13

return {
    id='line_scratch',
    draw=function(amount, control, params, t)
		for a=0,46 do
			local x=rand(240)
			local y=rand(136)
			local w=rand(20)
			line(x,y,x+w,y,pix(x,y))
			line(x,y+1,x+w/2,y+1,pix(x,y))
		end
	end,
}

end

rift_codescn=function()
Scn={}

function Scn:new(pal)
	local yLines={}
	for i=0,135 do
		yLines[i] = {
			rgbs={}
		}
	end

	local o = {
		pal=pal,
		yLines=yLines,
		lerpPal=1,	-- 1 (current) -> 0 (old)
		-- This could be improved...
		oldPal=pal,
	}

	setmetatable(o, self)
	self.__index = self
	return o
end

function Scn:setPalette(pal)
	-- If lerp is not 1 then make a temporary palette to migrate from
	self.oldPal = self.pal
	self.pal = pal
	self.lerpPal = 0
end

function Scn:update(t)
	local lerp, invLerp = self.lerpPal, 1-self.lerpPal
	for y=0,135 do
		local oldRgbs = self.oldPal.get(y, t)
		local newRgbs = self.pal.get(y, t)
		local rgbs = {}
		for ci = 0,47 do
			rgbs[ci] = lerp * newRgbs[ci] + invLerp * oldRgbs[ci]
		end

		self.yLines[y] = {rgbs=rgbs}
	end
	self.lerpPal = min(self.lerpPal + 0.05, 1)
end

function Scn:get(y)
	return self.yLines[y]
end


end

rift_effectquup=function()
-- was: effect index = 5
return {
	id='quup',
	boot=function()
	end,
	draw=function(control, params, t)
		local tt=t/8 * control
		local P=3+tt//5%5
		local Q=P/2
		local I=tt/15%1
		for i=1,20 do
			for j=0,P-1,1 do
				local r=tt+pi*j/Q-i*sin(tt/50)
				local n=120+(i+I)*9*sin(r)
				local o=68+(i+I)*9*cos(r)
				r=tt+pi*(j+1)/Q-i*sin(tt/50)
				line(n,o,120+(i+I)*9*sin(r),68+(i+I)*9*cos(r),i+1)
				local l=i-1
				r=tt+pi*j/Q-l*sin(tt/50)
				if i>1 then 
					k=(l+I)*9 
				else 
					k=l*9 
				end
				line(n,o,120+k*sin(r),68+k*cos(r),i+1)
			end
		end
	end,
}

end

rift_modifierpostcirc=function()
-- Was: modifier index = 4

return {
	id='post_circ',
	draw=function(amount, control, params, t)
		t = t*40
		local lim = clamp(8 + control,0,15)
		for y=0,135 do 
			for x=0,239 do
				local dx,dy=120-x,68-y
				local d=sqrt(dx^2+dy^2)//1
				local a=atan2(dx,dy)
				if((10*sin(t/4+d/5))%100>50) then
					local c=pix(x,y)
					if c>lim then
						pix(x,y,clamp(c-8,0,15))
					end
				end 
			end 
		end
	end,
}

end

rift_modifierrotvert=function()
-- Was: modifier index = 7

return {
	id='rot_vert',
	draw=function(amount, control, params, t)
		local dir=1
		local lines = 0
		if control == 0 then
			lines = t%5//1
		else
			if control < 0  then
				dir = -1
			end
			--lines = abs(control)*(t%4+1)//1
			lines = (abs(control)*(t+1)//1)%136
		end

		if dir == 1 then
			-- going down
			memcpy(0x8000,(135-lines)*120,120*lines)
			for y=135-lines,0,-1 do
				memcpy((y+lines)*120,y*120,120)
			end
			memcpy(0,0x8000,120*lines)
		elseif dir == -1 then
			-- going up
			memcpy(0x8000,0,120*lines)
			for y=0,135-lines do
				memcpy(y*120,(y+lines)*120,120)
			end
			memcpy((136-lines)*120,0x8000,120*lines)
		end  
	end,
}

end

rift_palettedutch=function()
-- was: palette index 6

local palette = {}

return {
	id="dutch",
	boot=function()
	end,
	get=function(y, t)
		local it=t
		local grader=sin(it*1/7+y/150)+1
		local gradeg=sin(it*1/13+y/150)+1
		local gradeb=sin(it*1/11+y/150)+1
		local rgbs = {}
		for i=0,15 do
			rgbs[i*3]=clamp(i*16*(grader),0,255)
			rgbs[i*3+1]=clamp(i*16*(gradeg),0,255)
			rgbs[i*3+2]=clamp(i*16*(gradeb),0,255)
		end
		return rgbs
	end,
}



end

rift_codedraw=function()
function arc(x,y,w,r,ca,wa,col)
	for i=ca-wa/2,ca+wa/2,.1/r do
	local si,ci=sin(i),cos(i)
	line(x+r*si,y+r*ci,x+(r+w)*si,y+(r+w)*ci,col)
	end
end
  
function tangent(x,y,w,r,ca,l,col)
	local cx,cy=r*sin(ca),r*cos(ca)
	local wx,wy=(r+w)*sin(ca),(r+w)*cos(ca)
	local tx,ty=l*sin(ca-pi/2),l*cos(ca-pi/2)
	for i=-l,l,.5 do
		line(x+cx+tx*i/l,y+cy+ty*i/l,x+wx+tx*i/l,y+wy+ty*i/l,col)
	end
end

function printlogo(x,y,kx,ky,col)
	for i=1,5 do
		local l=string.len(logo[i])
		for ch=1,l do
			print(string.sub(logo[i],ch,ch),x+(ch-1)*kx,y+(i-1)*ky,col+i,true,1,true)
		end
	end
end

end

rift_effectfftcirc=function()
-- was: effect index = 13
local FC_osize=20

return {
	id='fft_circ',
	boot=function()
	end,

	draw=function(control, params, t)
		local size=FC_osize+params.bass*2 + control
		local ffth=params.ffth

		for r=0,255 do
			local a=(r/255+r)*tau
			local k=r//3
			local c=((ffth[(k-1)%256]+ffth[(k+1)%256])/2+ffth[k])*600*((k/255)*1.5+.015)
			local x,y=(size)*sin(a),(size)*cos(a)
			local x1,y1=(size+c/4*control)*sin(a), (size+c/4*control)*cos(a)
			--pix(120+x,68+y,1+c)
			line(120+x,68+y,120+x1,68+y1,1+min(14,c))
		end
	end,
}

end

rift_overlaystickerlens=function()
-- was: overlay index = 11

return {
	id="sticker_lens",
	boot=function()
	end,
	draw=function(control, params, t)
		local bass = params.bass
		local ffth = params.ffth

		-- draw point data to spritesheet
		-- first blank
		--memset(0x4000,0,120*136)

		local size=100+40*bass
		local hs=size/2
		-- #TODO: Hello - what are these?
		TWp = TImages[clamp(TIimageID,1,#TImages)]
		for i=1,#TWp do
			p=TWp[i]

			local x=(p[1]-120)/control
			local y=(p[2]-68)/control
			local c=clamp(ffth[p[5]//1]*50*(.05 + p[5]/10)+t,0,15)
			local a=p[4]
			local d=p[5]/control

			local b=bass/5
			--local focal=(d/(hs*t%2))^(b)
			local focal=1+sin(d/20+t/20)*(b+t%1/2)
			d=d*focal--*(t%1+.5)

			local ix,iy=d*sin(a),d*cos(a)
			if d < size then
				local ox,oy=ix+120,iy+68
				if ox >=0 and ox<240 and oy>=0 and oy<136 then -- #TODO: unnecessary check?
					pix(ox,oy,c)
				end
			end
		end
	end,
}

end

rift_paletteblueorange=function()
local palette = {}

return {
	id="blue_orange",
	boot=function()
		for i=0,47 do
			palette[i]=clamp(sin(i)^2*i,0,255)
		end
	end,
	get=function(y, t)
		return palette
	end,
}

end

rift_codepalette=function()

function makePalette2(r1,g1,b1,r2,g2,b2)
	local pal={}
	for i=0,15 do
		pal[i*3]   = clamp(r1*abs(15-i)/15 + r2*abs(i)/15,0,255)
		pal[i*3+1] = clamp(g1*abs(15-i)/15 + g2*abs(i)/15,0,255)
		pal[i*3+2] = clamp(b1*abs(15-i)/15 + b2*abs(i)/15,0,255)
	end
	return pal
end

function makePalette3(r1,g1,b1,r2,g2,b2,r3,g3,b3)
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


function loadRGBs(rgbs)
	local pal={}
	local index=0
	for _,v in ipairs(rgbs) do
		pal[index] = v
		index = index + 1
	end
	return pal
end

end

rift_effectvoltest=function()
-- was: effect index = 0
return {
    id='vol_test',
    boot=function()
    end,
	draw=function(control, params, t)
        for i=239,0,-1 do
            for j=0,135 do
                pix(i,j,(pix(i+1,j)))
            end
        end
        line(239,0,239,136,0)

        print("TIME",0,20,3)
        pix(239,20+t/1000,3)
        print("TBEAT",0,50,6)
        pix(239,60+params.bt,6)
        print("TBASS",0,80,9)
        pix(239,100+params.bass,9)
        print("TBASSC",0,110,12)
        pix(239,110+params.bassc/100,12)
    end,
}

end

rift_effectrevisionback=function()
-- was effect index = 16

local cubes ={}
local cubeLines = {
    {-1,-1,-1,1,-1,-1},
    {-1,-1,-1,-1,1,-1},
    {-1,-1,-1,-1,-1,1},

    {1,-1,-1,1,1,-1},
    {1,-1,-1,1,-1,1},

    {-1,1,-1,-1,1,1},
    {-1,1,-1,1,1,-1},

    {1,1,-1,1,1,1},

    {-1,1,1,1,1,1},
    {-1,1,1,-1,-1,1},

    {-1,-1,1,1,-1,1},
    {1,1,1,1,-1,1},
}

return {
	id='revision_back',
	boot=function()
	end,
	draw=function(control, params, t)
		RB_cubes={}
		local ifft=params.bass
		for i = 1,5 do
			for j = 1,16 do
				table.insert(cubes,{(13+ifft)*sin((j/16+t)*tau+i/15),(13+ifft)*cos((j/16+t)*tau+i/15),10+i*4})
			end
		end

		for i=1,#cubes do
			for j=1,#cubeLines do
				local ln=cubeLines[j]

				local x1=(ln[1]+cubes[i][1]) *99/(cubes[i][3]+ln[3])
				local y1=(ln[2]+cubes[i][2])*99/(cubes[i][3]+ln[3])
				local x2=(ln[4]+cubes[i][1])*99/(cubes[i][3]+ln[6])
				local y2=(ln[5]+cubes[i][2]) *99/(cubes[i][3]+ln[6])
				line(x1+120,y1+68,x2+120,y2+68,16-cubes[i][3]/2)
			end
		end
	end,
}

end

rift_overlaybobs=function()
-- was: overlay index = 8

return {
	id="bobs",
	boot=function()
	end,
	draw=function(control, params, t)
		local mid=params.mid
		for i=0,99 do
			local j=i/12
			local x=10*sin(pi*j+t)
			local y=10*cos(pi*j+t)
			local z=10*sin(pi*j)
			local X=x*sin(t)-z*cos(t)
			local Z=x*cos(t)+z*sin(t)
			circ(120+X*Z,68+y*Z,Z,control*mid)
		end
	end,
}

end

rift_overlaylinecut=function()
-- was: overlay index = 10

return {
    id="line_cut",
    boot=function()
    end,
	draw=function(control, params, t)
        local s=10+control
        local x=(t*s*2)%s*4
        for sx=-136,240+s+136,s*4 do
            for y=0,136+s,s do
                local cx=sx-y+x
                tri(cx,y-s,cx-s,y,cx,y+s,1)
                tri(cx,y-s,cx+s,y,cx,y+s,1)
            end
        end
    end,
}

end

rift_overlaysinebobs=function()
-- was: overlay index = 2

return {
	id="sinebobs",
	boot=function()
	end,
	draw=function(control, params, t)
		-- #TODO: time() is unusual - check that's right?
		local tt=time()+t*1000
		for x=-9,9 do
			for y=-5,5 do
				circ(x*11+120, y*10+68,
					3*sin(tt/400+x/2-y/3*sin(tt/300+y/10))+3,
					13
				)

				circ(x*11+120, y*10+68,
					3*sin(tt/400+x/2-y/3*sin(tt/300+y/10)),
					12
				)
			end
		end
	end,
}

end

rift_overlaytextwarp=function()
-- was: overlay index = 4
local TWp={}
local TWfirst = true

function ScreenToPoints()
	local p={}
	for y=0,135 do 
		for x=0,239 do
			if pix(x,y) == 12 then 
				if x < 80 then
					c = 6 
				elseif x < 160 then
					c = 12
				else
					c = 3
				end
				local d=((x-120)^2+(y-68)^2)^.5
				local a=atan2(x-120,y-68)
				local nx,ny=d*sin(a),d*cos(a)

				table.insert(p,{x,y,c,a,d})
			end
		end
	end
	return p
end

return {
	id='text_warp',
	boot=function()
		cls()
		local l=flength("GOTO80",3,4)
		fprint("GOTO80",120-l/2,38,3,1,12,4)
		TWp = ScreenToPoints()
		table.insert(TImages,TWp)

		cls()
		l=flength("LOVEBYTE",3,2)
		fprint("LOVEBYTE",120-l/2,35,3,1,12,2)
		l=flength("2024",3,2)
		fprint("2024",120-l/2,70,3,1,12,2)
		TWp = ScreenToPoints()
		table.insert(TImages,TWp)
	end,
	draw=function(control, params, t)
		local bass,mid,high = params.bass,params.mid,params.high
		local it=sin(t/4*tau)^2
		TWp = TImages[clamp(TIimageID,1,#TImages)]
		for i=1,#TWp do
			local pp=TWp[i]
			local b=pp[4]+2*pi*sin(it*pp[5]/100+mid)
			local w=pp[5]/2+10*sin(pp[5]/40*bass)+(it/control)*pp[5]+high
			local nx,ny=w*sin(b),w*cos(b)
			pix(120+nx,68+ny,15)
		end
	end,
}

end

rift_modifierpixzoom=function()
-- Was: modifier index = 2

return {
    id='pix_zoom',
    draw=function(amount, control, params, t)
        local d=1+2*rand()
        for i=1,amount do
            local x,y = 240*rand(),136*rand()
            local a=atan2(x-120,y-68)

            local op=pix(x,y)-control
            if op >= 0 then
                pix(x+d*(sin(a)+sin(t/300)),y+d*(cos(a)+sin(t/300)), op)
            else
                pix(x+d*sin(a),y+d*cos(a),0)
            end
        end
    end,
}

end

rift_codemath=function()
function clamp(x,a,b)
	return max(a,min(b,x))
end

function smoothStep(x,e1,e2)
	local y=clamp(x,e1,e2)
	local st=(y-e1)/(e2-e1)
	return st*st*(3-2*st)
end

end

rift_codeglobals=function()
m=math
sin,cos,max,min=m.sin,m.cos,m.max,m.min
abs,pi,rand,randseed,exp=m.abs,m.pi,m.random,m.randomseed,m.exp
sqrt,atan2=m.sqrt,m.atan2
tau=pi*2

end

rift_modifierpixmotionblur=function()
-- Was: modifier index = 5

local PMBsize = 20
return {
    id='pix_motion_blur',
    draw=function(amount, control, params, t)
        local size = PMBsize+(t)%5
        local limit = 50 + control
        for i=0,amount/4 do
            local d = 2+size+rand(limit)
            local a = rand()*tau
            local x,y = d*sin(a),d*cos(a)
            if x >= -119 and x <= 118 and y >=-67 and y <= 66 then
                pix(120+x,68+y,clamp(((pix(120+x,68+y)+pix(120+x-1,68+y-1)+pix(120+x+1,68+y-1)+pix(120+x-1,68+y+1)+pix(120+x+1,68+y+1))/4.8),0,15))
            end
        end

        for i=0,amount do
            local d=size+rand(limit)
            local a=rand()*tau
            local x,y=d*sin(a), d*cos(a)
            if x >= -120 and x <= 119 and y >=-68 and y <= 67 then
                pix(120+x,68+y,pix(120+(d-1)*sin(a),68+(d-1)*cos(a)))
            end
        end
    end,
}

end

rift_modifiersfthorz=function()
-- Was: modifier index = 10

return {
	id='sft_horz',
	draw=function(amount, control, params, t)
		local dir=1
		local pixels = 0
		if control == 0 then
			pixels = t%5//1
		else
			if control < 0  then
				dir = -1
			end
			--pixels = abs((control*t)%120)
			--pixels = (abs(control)+(t*2))%120
			pixels = (abs(control)*(t+1)//1)%120
		end

		if dir ==1 then
			-- going right
			for y=0,135 do
				-- take the whole line
				memcpy(0x8000,y*120, 120)

				-- put it back in two sections
				memcpy(y*120+pixels,0x8000, 120-pixels)
				memset(y*120,0, pixels)
			end
		else
			-- going left
			for y=0,135 do
				-- take the whole line
				memcpy(0x8000,y*120, 120)

				-- put it back in two sections
				memset(y*120+(120-pixels),0, pixels)
				memcpy(y*120,0x8000+pixels, 120-pixels)
			end
		end
	end,
}

end

rift_palettetrans=function()
-- was: palette index 12

local palette = {}

return {
	id="trans",
	boot=function()
		palette = makePalette3(0x55,0xcd,0xfc,255,255,255,0xf7,0xa8,0xb8)
	end,
	get=function(y, t)
		return palette
	end,
}

end

rift_effectattunnel=function()
-- was: effect index = 4
return {
	id='at_tunnel',
	boot=function()
	end,
	draw=function(control, params, t)
		local ta=smoothStep((t*4)%4/4,0,1)
		for j=1,20 do
			local n=3+j
			local d=(4*j-t%64)
			if d~=0 then
				d=99/d
			end

			if d<120 and d >5 then 
				local w=(params.mid*2)*d/6
				local chroma=.01*(1+sin(ta))
				local cr=smoothStep((t/4+2*j)%5,2,4)*tau+control*t/2
				if j%2 == 0 then
					for i=1,n do
						if (t/4%8 < 4) then
							arc(120,68,w,d,cr + tau/n*i +j/10,pi/n,12)
						else
							arc(120,68,1,d*(1-chroma),cr + tau/n*i +j/10,pi/n,2)
							arc(120,68,1,d+w,cr + tau/n*i +j/10,pi/n,10)
							arc(120,68,w,d,cr + tau/n*i +j/10,pi/n,12)
						end
					end
				else
					for i=1,n do
						if (t/4%6 < 3) then
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
	end,
}

end

rift_effectlemons=function()
-- Was effect index = 15

local LE_points={}
local LE_lines={}
local LE_columns={}
local LE_rd={}
local LE_np=15
local LE_nl=15
local LE_nc=5

return {
	id='lemons',
	boot = function()
		for i=1,LE_nl do
			local lp={}
			for j=1,LE_np do
				lp[j]=5*rand()
			end
			LE_rd[i]=lp
		end
	end,
	draw = function(control, params, t)
		local h=0
		local n=0

		local numlem = clamp(LE_nc+control,1,20)

		local ccp={}
		t=t*tau
		for h=1,numlem do
			local a = h/numlem * tau
			ccp[h]={x=100*sin(a+t/7), y=0, z=30*cos(a+t/7), n=h}
		end

		table.sort(ccp, function (a,b) return a.z<b.z end)

		for h=1,numlem do
			LE_lines={}
			local ffth=params.ffth
			for i=1,LE_nl do
				local lp={}
				for j=1,LE_np do
					local a = j/LE_np * tau
					local p = {
						x=(20+LE_rd[i][j]+ffth[i]*10)*sin(a+t)*sin(i/LE_nl*pi),
						y=(i-(LE_nl/2))*4,
						z=(20+LE_rd[i][j]+ffth[i]*10)*cos(a+t)*sin(i/LE_nl*pi)
					}
					a = t/4+h
					lp[j]={
						x=p.x*sin(a)-p.y*cos(a),
						y=p.y*sin(a)+p.x*cos(a),
						z=p.z
					}
				end
				LE_lines[i]=lp
			end
			LE_columns[h]=LE_lines
		end 

		for k=1,numlem do
			if ccp[k].z >-23 then
				local h=ccp[k].n
				for i=1,LE_nl do
					for j=1,LE_np-1 do
						local sp=LE_columns[h][i][j]
						local ep=LE_columns[h][i][j+1]

						if(sp.z+ep.z)>0 then
							local sz=sp.z-100+ccp[k].z
							local ez=ep.z-100+ccp[k].z
							local sx=120+sp.x*99/sz+ccp[k].x
							local sy=68+sp.y*99/sz+ccp[k].y
							local ex=120+ep.x*99/ez+ccp[k].x
							local ey=68+ep.y*99/ez+ccp[k].y
							line(sx,sy,ex,ey,ez/8)
						end
						--pix(120+sp.x*99/sz,68+sp.y*99/sz,12)
					end
				
					local sp=LE_columns[h][i][LE_np]
					local ep=LE_columns[h][i][1]

					if(sp.z+ep.z)>0 then
						local sz=sp.z-100+ccp[k].z
						local ez=ep.z-100+ccp[k].z
						local sx=120+sp.x*99/sz+ccp[k].x
						local sy=68+sp.y*99/sz+ccp[k].y
						local ex=120+ep.x*99/ez+ccp[k].x
						local ey=68+ep.y*99/ez+ccp[k].y
						line(sx,sy,ex,ey,ez/8)
					end
					--  line(minx,miny,maxx,maxy,1)
				end
			end
		end
	end,
}


end

rift_overlaysmokecircles=function()
-- was: overlay index = 6
local SC_p={}
local SC_np = 99

return {
	id="smoke_circles",
	boot=function()
		for i=0,SC_np do
			SC_p[i]={x=4-8*rand(),y=4-8*rand(),z=20*rand()}
		end
	end,
	draw=function(control, params, t)
		local tt=t*5
		for i=0,SC_np do
			local z=(SC_p[i].z+tt)%20
			local x=SC_p[i].x
			local y=SC_p[i].y
			local t2=-(1-z/9)
			local X=x*cos(t2)-y*sin(t2)
			local Y=y*cos(t2)+x*sin(t2)
			circ(120+X*z,68+Y*z,20-z,15-(z/1.5))
		end  
	end,
}

end

rift_overlaytextbounceup=function()
-- was: overlay index = 1

return {
	id="text_bounce_up",
	boot=function()
	end,
	draw=function(control, params, t)
		if params.oDivider ~= 0 then
			tt=t/BT//params.oDivider
			tx=abs(tt)%#Texts[TextID] + 1
			y=140-160*(t%1)
		else
			tt=t/BT//1
			tx=abs(tt)%#Texts[TextID] + 1
			-- count how many line breaks
			linecount=1
			for i=1, #Texts[TextID][tx] do
				if string.sub(Texts[TextID][tx],i,i) == "\n" then
					linecount=linecount+1
				end
			end
			y=68 - (3+control)*3 *linecount
		end
		local tc=clamp(MID*15,8,15)
		local tl=flength(Texts[TextID][tx],1,control)
		fprint(Texts[TextID][tx],120-tl/2,y,1,1,15,control)
	end,
}

end

rift_palettesweetie16=function()
-- was: palette index 0

local rgbs = loadRGBs({
	0x1a,0x1c,0x2c,
	0x5d,0x27,0x5d,
	0xb1,0x3e,0x53,
	0xef,0x7d,0x57,
	0xff,0xcd,0x75,
	0xa7,0xf0,0x70,
	0x38,0xb7,0x64,
	0x25,0x71,0x79,
	0x29,0x36,0x6f,
	0x3b,0x5d,0xc9,
	0x41,0xa6,0xf6,
	0x73,0xef,0xf7,
	0xf4,0xf4,0xf4,
	0x94,0xb0,0xc2,
	0x56,0x6c,0x86,
	0x33,0x3c,0x57,
})

return {
	id="sweetie_16",
	boot=function()
	end,
	get=function(y, t)
		return rgbs
	end,
}

end

rift_effectbrokenegg=function()
-- was: effect index = 11
local BE_p={}
local BE_sz=25
local BE_depth=5

return {
	id='broken_egg',
	boot=function()
	end,
	draw=function(control, params, t)
		BE_p={}
		t=t*tau*(control+.5)
		for i=1,BE_sz^2 do
			local y=i//(BE_sz/2)-BE_sz/2 + params.ffth[clamp((i/10)%256,0,255)//1]*100*i/255
			local a=(i%BE_sz)/BE_sz*tau
			local d=BE_sz/2*sin(t/BE_depth)+BE_sz*sin(y/BE_sz)
			local x,z=d*sin(a+t/13),d*cos(a+t/13)
			local a2=t/11
			BE_p[i]={x=x*cos(a2)-y*sin(a2),y=y*cos(a2)+x*sin(a2),z=z}
		end
		for i=2,#BE_p do
			line(120+BE_p[i].x*BE_p[i].z/9+20*sin(BE_p[i].y/5),
				58+BE_p[i].y*BE_p[i].z/9,
				120+BE_p[i-1].x*BE_p[i-1].z/9+20*sin(BE_p[i-1].y/5),
				58+BE_p[i-1].y*BE_p[i-1].z/9,
				clamp((abs(BE_p[i-1].z)+abs(BE_p[i].z))/2,0,15)
			)
		end
	end,
}

end

rift_overlaysmileyfaces=function()
-- was: overlay index = 3

local NumSmilyFaces = 30
local SmilyFaces_xysr = {}

return {
	id="smiley_faces",
	boot=function()
		for i=1,NumSmilyFaces do
			SmilyFaces_xysr[i]={rand(300),rand(200)-32,rand(20)+10,rand()*tau}
		end
		table.sort(SmilyFaces_xysr, function (a,b) return a[3]<b[3] end)
	end,
	draw=function(control, params, t)
		local nsf = clamp(control,1,NumSmilyFaces)
		local fftc = params.fftc
		for i=1,nsf do
			local fft=fftc[i]
			local sm=SmilyFaces_xysr[i]
			local x=(sm[1])%300 - 30
			local y=(sm[2]+fft*2*i^0.8)%200 - 32
			local s=(sm[3])
			local a=sin(fft*2)-tau/4

			local ds = s/20
			local x1=9*sin(a)-7*cos(a)
			local y1=9*cos(a)+7*sin(a)
			local x2=-9*sin(a)-7*cos(a)
			local y2=-9*cos(a)+7*sin(a)
			circ(x,y,s,(i%15)+1)
			circ(x+x1*ds,y+y1*ds,4*ds,0)
			circ(x+x2*ds,y+y2*ds,4*ds,0)
			local l=15*ds
	
			for j=-l,l do
				circ(x+12*ds*sin(j/l+a+tau/4),y+10*ds*cos(j/l+a+tau/4),1,0)
			end
		end
	end,
}

end

rift_palettegreyscale=function()
-- was: palette index 4

local palette = {}

return {
	id="grey_scale",
	boot=function()
		for i=0,47 do
			palette[i]=i*5.6
		end
	end,
	get=function(y, t)
		return palette
	end,
}

end

rift_effecttwistfft=function()
-- was: effect index = 1

local TF_size=200
return {
    id='twist_fft',
    boot=function()
    end,

	draw=function(control, params, t)
        local it=t*10*control
		local ffth=params.ffth
		local bass=params.bass
        -- lets do the twist again
        for i=0,239 do
            local x=(i-it//1)%240
            local fhx = (ffth[(x-1)%240]+ffth[(x)%240]+ffth[(x+1)%240])/3*(.9+x/60)
            local a=sin(it/10)* x/80
        
            local d=TF_size*fhx+5+5*bass
        
            local cy = 68+10*bass*sin(i/110+ it/12)
        
            local y1=d*sin(a)
            local y2=d*sin(a + tau/4)
            local y3=d*sin(a + tau/2)
            local y4=d*sin(a + tau*3/4)
        
            d=d/4
        
            if y1 < y2 then
                line(i,cy+y1,i,cy+y2,clamp(d,0,15))
            end
            if y2 < y3 then
                line(i,cy+y2,i,cy+y3,clamp(d+1,0,15))
            end
            if y3 < y4 then
                line(i,cy+y3,i,cy+y4,clamp(d+2,0,15))
            end
            if y4 < y1 then
                line(i,cy+y4,i,cy+y1,clamp(d+3,0,15))
            end
        end
    end,
    bdr=function(l)
        local lm=68-abs(68-l)
        for i=0,47 do
            poke(16320+i,clamp(sin(i)^2*i*lm/5.5,0,255))
        end
    end,
}

end

rift_effectparaflower=function()
-- was: effect index = 12
local PF_depth = 3
local PF_t=0


return {
	id='para_flower',
	boot=function()
	end,
	draw=function(control, params, t)
		local ifft=params.bass
		PF_t=PF_t+1
		for y=0+(PF_t%4)//1,135,4 do 
			for x=0,239 do
				dx,dy=x-120,y-68
				a=atan2(dx,dy)
				d=sqrt(dx^2+dy^2)
				pix(x,y,8+8*sin((5*ifft)*sin((PF_depth+control)*a+t*tau)+d/10+t))
			end
		end
	end,
}

end

rift_overlayrevisiontop=function()
-- was: overlay index = 12

return {
	id="revision_top",
	boot=function()
	end,
	draw=function(control, params, t) 
		--[[
		local rlp={}
		local ca = t * tau
		local bass = params.bass
		for x=-10,10 do
			for y=-10,10 do
				--dy=y*.8
				local d = (x^2+y^2)^.5 * (1+t%1/10)
				local a = atan2(x,y) + ca
				local s = (16-control)-2*d+bass*5--abs(x)-abs(y)
				local nx,ny = d * sin(a), d * cos(a)
				if s >= .5 then
					table.insert(rlp,{nx,ny,s})
				end
			end
		end

		for _,p in ipairs(rlp) do
			circ(120+9.5*p[1],68+8.5*p[2],p[3],8)
		end

		for _,p in ipairs(rlp) do
			circ(120+10*p[1],68+9*p[2],p[3],12)
		end 
		--]]
	end,
}

end

rift_overlaysnow=function()
-- was: overlay index = 5

return {
	id="snow",
	boot=function()
	end,
	draw=function(control, params, t)
		for i=0,OControl do
			circ(rand(240),rand(136),rand(4),t)
		end
	end,
}

end

rift_modifiersftvert=function()
-- Was: modifier index = 9

return {
    id='sft_vert',
    draw=function(amount, control, params, t)
        dir=1
        local lines = 0
        if control == 0 then
            lines = t%5//1
        else
            if control < 0  then
                dir = -1
            end
            --    lines = abs(control)*(t%4+1)//1
            lines = (abs(control)*(t+1)//1)%136
        end

        if dir == 1 then
            -- going down
            for y=135-lines,0,-1 do
                memcpy((y+lines)*120,y*120,120)
            end
            memset(0,0,120*lines)
        elseif dir == -1 then
            -- going up
            for y=0,135-lines do
                memcpy(y*120,(y+lines)*120,120)
            end
            memset((136-lines)*120,0,120*lines)
        end
    end,
}

end

rift_palettereddish=function()
-- was: palette index 2

local palette = {}

return {
	id="reddish",
	boot=function()
		for i=0,15 do
			palette[i*3]=clamp(i*32,0,255)
			palette[i*3+1]=clamp(i*24-128,0,255)
			palette[i*3+2]=clamp(i*24-256,0,255)
		end
	end,
	get=function(y, t)
		return palette
	end,
}

end

rift_paletteinverted=function()
-- was: palette index 10

local palette = {}

return {
	id="inverted",
	boot=function()
	end,
	get=function(y, t)
		local it=t/8

		local grader=sin(it*1/7+y/150)+1
		local gradeg=sin(it*1/13+y/150)+1
		local gradeb=sin(it*1/11+y/150)+1
		local rgbs={}
		for i=0,15 do
			rgbs[i*3] = 255-(8+4*grader)*i
			rgbs[i*3+1] = max(0,min(255,255-(8+4*gradeg)*i))
			rgbs[i*3+2] = max(0,min(255,255-(8+4*gradeb)*i))
		end
		return rgbs
	end,
}

end

rift_paletteukr=function()
-- was: palette index 11

local palette = {}

return {
	id="ukr",
	boot=function()
		palette = makePalette3(0,0,0,0x00,0x5b,0xbb,0xff,0xd5,0x00)
	end,
	get=function(y, t)
		return palette
	end,
}

end

rift_paletteeire=function()
-- was: palette index 13

local palette = {}

return {
	id="eire",
	boot=function()
		palette = makePalette3(0x00,0x9a,0x44,255,255,255,0xff,0x82,0x00)
	end,
	get=function(y, t)
		return palette
	end,
}

end

rift_effecttunnelwall=function()
-- was: effect index = 6
return {
	id='tunnel_wall',
	boot=function()
	end,

	draw=function(control, params, t)
		t=t/2
		local ffth=params.ffth
		for x=0,239 do
			for y=0,135 do
				local sx,sy=x-120*sin(t),y-68 
				local r=99+50*sin(t/3) - control*2
				local s,c=sin(t),cos(t)
				local X,Y=(sx*s-sy*c),(sy*s+sx*c)
				local k,l=X%r-r/2, Y%r-r/2
				local a=atan2(k,l)
				local e=(k*k+l*l)^.5  
				local K,L=X//r,Y//r 
				local ff = clamp(abs(K+L)//1 + 10,0,255) *.2 + K
				pix(x,y,((99/e)*2*sin(t*ff+K+L)-a*2.55)%(8)+K+L*4)
			end
		end
	end,
}

end

rift_overlayjoydivision=function()
-- was: overlay index = 9

local JD_ffts={}
local JD_oldffts={}
local JD_ft={}
local JD_fi=0
local JD_ot=0

return {
	id="joy_division",
	boot=function()
		for i=1,8 do
			table.insert(JD_ffts,{})
		end
	end,

	draw=function(control, params, t)
		local ffth=params.ffth
		if control~=0 and JD_ot%control == 0 then
			JD_ft={}
			for j=0,255 do
				table.insert(JD_ft,ffth[j])
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

		local int=0
		for i=1,#JD_ffts do
			JD_ft=JD_ffts[i]
			if #JD_ft > 0 then
				for j=1,127 do
					local k=(JD_ft[j*2]+JD_ft[j*2+1])*(j/255 + .05)
					k=k*400
					int=(int + k)/2
					pix(54+j,8+i*12-int,15-i/4)
				end
			end
		end

		print("Tic80 Division",54,116,15)
	end,
}

end

rift_effectswirltunnel=function()
-- was: effect index = 8
return {
	id='swirl_tunnel',
	boot=function()
	end,
	draw=function(control, params, t)
		local ifft=params.bass
		t=t/10
		local k,l=sin(t*tau)*99, sin(t*tau*2)*49
		for i=0,32639 do
			local x,y=i%240-k-120,i/240-l-68
			local u=atan2(y,x)
			local d=(x*x+y*y)^.5
			local v=99/d
			local c=sin(v+(u+sin(v)*sin(ifft/4)*tau)+t/1000)+1
			poke4(i,clamp(c*8-c*((138-d)/138),0,15))
		end
	end,
}

end

rift_palettebluegreysine=function()
-- was: palette index 3

local palette = {}

return {
	id="blue_grey_sine",
	boot=function()
		for i=0,47 do
			palette[i]=sin(i/15)*255
		end
	end,
	get=function(y, t)
		return palette
	end,
}

end

rift_effectcirclecolumn=function()
-- was: effect index = 10
local CC_p={}
local CC_sz = 25

return {
	id='circle_column',
	boot=function()
	end,
	draw=function(control, params, t)
		t=t*tau
		CC_p={}
		for i=1,CC_sz^2 do
			local y = i//(CC_sz/2)-CC_sz/2
			local a = (i%CC_sz)/CC_sz*tau
			local d = CC_sz+CC_sz/3*cos(y/5+t/4)+FFTH[clamp(i/10+5,0,255)//1]*(i/255)*500-- ifft
			local x,z = d*sin(a+t/7+sin(y/CC_sz)), d*cos(a+t/7+sin(y/CC_sz))
			CC_p[i]={x=x,y=y,z=z}
		end

		table.sort(CC_p, function(a,b) return b.z > a.z end)

		for i=1,#CC_p do
			if CC_p[i].z > 15+control then
				circ(120+CC_p[i].x*CC_p[i].z/9+20*sin(CC_p[i].y/5),48+CC_p[i].y*CC_p[i].z/5,CC_p[i].z/5,clamp(CC_p[i].z/2,0,15))
			end
		end
	end,
}

end

rift_effectbitnick=function()
-- was: effect index = 17
-- #TODO Check this wasn't an overlay
return {
    id = 'bitnick',
    boot = function()
    end,
    draw = function(control, params, t)
		randseed(2)
		local tt = (t / control)
		for x = 0, 51 do
			local w = rand() * 70 + 30
			local h = rand() * 20 + 10
			local posx = (rand() * 240 + (tt / w * 4) * x / 20) % (240 + w + x) - w
			local posy = rand() * (136 + h) - h
			local col = rand() * 2 + cos(tt / 2000) * 2 + 5

			clip(posx, posy, w, h)
			for i = posx, posx + w do
				circ(i, posy + i // 1 % h, w / (col + 16), col + i / 300)
			end
			clip()
		end
	end,
}

end

rift_palettepastels=function()
-- was: palette index ?

local palette = {}

return {
	id="pastels",
	boot=function()
	end,
	get=function(y, t)
		local it=t/8
		local rgbs = {}
		for i=0,47 do
			rgbs[i]=(sin(it/8*sin(i//3)+(i%3)))*99
		end
		return rgbs
	end,
}

end

rift_palettedimmed=function()
-- was: palette index 7

local palette = {}

return {
	id="dimmed",
	boot=function()
	end,
	get=function(y, t)
		local it=t
		local rgbs = {}
		for i=0,15 do
			rgbs[i*3] = clamp(i*(8+8*(sin(tau/6*5+it+y/100))), 0, 255)
			rgbs[i*3+1] = clamp(i*(8+8*(sin(it+y/100))), 0, 255)
			rgbs[i*3+2] = clamp(i*(8+8*(cos(it+y/100))), 0, 255)
		end
		return rgbs
	end,
}

end

rift_codefont=function()
local rle = "0800020ODODOHPDPHPHPHPHP4HPPHOHOHAHOHOHOHAHOHOHOHAHOP2HHAHOP2DHAHOPHOPOHHOPHP2HHOPHP2HHOHAHAHAHOHAHAHAHOPDPDHP3DPDHP3DPDHP2ODOPHOHAODOPHOHAODOPHOHAMBAOHOHAMBAOHOHAMBAOPHHAMBAOPDHAMBAOPHHAMPDAPDMHOPDAPHOP2DAP3HLDAHOHOHLDAHOHOHLDAHOHOHLDAHOHOHIDAHOHOP2HHAHOHOHOHAHOHOHOHAHOHOHOHAHOHOP5HOPHOP2HOPDMPPHA7HAHAHOHOHAHAHOHOHAHAHOHOHAHAHOHOPPHAPPHOPPHAOPHOOPHAMPHOA7MBAOHOHAMBAOHOHAMBAOHOHAMBAOHOHAPHPPHOP2HPPHOP2HPHHOOPA7HIDAHOHOHIDAHOHOHIDAHOHOHIDAHOHOHIDAHOPPHIDAHOPHHIDAHOODA7ODMHODMPPHOPPHOP8HOHOHOHAHOHOHOHAHOHOHOPDPPHOPHOHPHHOPDMP2BAHOHOPPBAHOHOPPBAHOHOIDAAHOHOIDAAHOHOIDAAHOHOIDAAHOHOIDAAHOHOHIDAHOH2IDAHOH2IDAHOH2IDAHOH2IDAHOH2IDAOH3IDAMDPHHIDAOHPHPPAAHA2PPAAHA2PPAAHA3OAAHA3OPDPDOHMPPHPHPHOHP4HPDAOHOHAPDHOPHAOHAHOHOAOHAHOHOAOHAHPHOAOHAPHHOPPHAPPHOPPHAONHOPHA7IDAAHOHOIDAAHOHOIDAAHOHOIDAAHOHOIDAAP3IDAAOPPHIDAAMPPDA7HLDAHOODHLDAHOMBHLDAHOMBHLDAHOMBPPDAHOMBOPDAHOMBMPBAHOMBA7HAOPHOHAHAPPHOHAHAPPHOHAHAHOHOHAP13OP2OPPHMPA8OAAMPA2OAAOPA2OAAOPA2OAAOA2MPOHPDMPOP3DOP5DPPHOHOOAHOHA4HAHAMBMBHAHAMBMBHAHA4HAPDPAPAHOPHPBPBHOP2BPBHOHOMBMBHOHA6HA6HA6HA6HAMPBAPDHAOPDAPHHAPPDAPPHAHLDAHOA31MHODMHMHOPPHOPOHP6HHOHOHOHAHOPPOAHOHOPPOAHOHOPHOAHOHOHAOAHOP3OAP3OPOAOPOPMPOAMPA6OHOMBMBPPHOMBMBPHHOMBMBPPHOMBMBHOHOMBMBHOHOMBMBHOHOMBMBHOA3MBAAHAHLDAHOHAHLDAHOHAHIDAHOHAHIDAHOPDHIDAHOPDHIDAHOODHIDAHOA7HOHOHOHAHOHOHOHAHOHOHOHAHOHOHOHAP5HAPHPHOPHAODPDMPHA2HAAOA7OPA5OHA5ODA43PBA5PBA5PA108HAAOA3HAAOA3HAAOA43HA6HA6HA6HA4MPPDHOHOOPPDHOHOP2DHOHOHAHAHOHOA31HIDAHOGOHIDAHOHOHIDAHOHOHIDAHOHOAAGAHA4HAHA4HAHA4HADA2PPHA4PPHA2MBPPHA2MBAOHA2PHA5IDA5IDA5IDA5MDA5MBA5MBA5MBAAPHAAOBPDHAHOHOOHHAHOHOMPHAHOHOAOHAHOHOP2HP5OHOPPHPHMHMPPDA7HIDAPPHOHLDAOHHOHLDAPPHOHLDAHOHOPPDAHOPPOPDAHOOPMPBAHOMPA6OMPHA2PHOHHA2PHPDHA2MBHA4MBPPHA4PPHA4PPHA14PHAAOA2PHAAOA6OA6PAHA2HAHAHA2HAHAHA2HAHADA76OPA5OHA5ODA167MHPBPHPHOPPDP6DP3HOIDAOAOHPIDAOAOHPIDMPMP2IDOHMHPPIDPDMPHOPPMP2HOPPOP2HOP5HOHAHAAOHOHAHAAOHOPDPDAP3HPHIHOPOP2MDMHMHA3OPOPA3P3A3HOHOA3HOHOA3PPHOHAPHOHPPHAPHP3HAPHPHIJDA2PPMJDA2PPMJDA3OP2A2MP3A2OHP2A2PDMJDA2HAMJDA2POIDHAAOPOIDHAAOHOIDHAAOHOIDHAAOPPIDP4HIDP2HODIDP2DA7MPAOHOMBAOAOHOMBAOAOHOMBAOAOHOMBAOP3MBAOPPOHMBAOPHMDMBA7HOOPHA2HOAOAAPHHOAOAAPHHOAOHAPHP3HA2PHPHHA2ODPDHA10PPMJDA2P4A2OP3A4P2A2MBMJDA2MBMJDA2MBMJBA10"
-- font data {"A", sprite number, page?, num sprites x, y, width (px), height}
fontd={	{0,0,1,2,8,16},{1,0,1,2,8,16},{2,0,1,2,8,16},{3,0,1,2,8,16},{4,0,1,2,8,16},{5,0,1,2,8,16},{6,0,1,2,8,16},{7,0,1,2,8,16},{8,0,1,2,7,16},{9,0,1,2,8,16},{10,0,1,2,8,16},{11,0,1,2,8,16},{12,0,2,2,10,16},{14,0,1,2,8,16},{15,0,1,2,8,16},
		{128,0,1,2,8,16},{129,0,1,2,8,16},{130,0,1,2,8,16},{131,0,1,2,8,16},{132,0,2,2,9,16},{134,0,1,2,8,16},{135,0,1,2,8,16},{136,0,2,2,10,16},{138,0,1,2,8,16},{139,0,1,2,7,16},{140,0,1,2,8,16},{141,0,1,2,8,16},{142,0,1,2,8,16},{143,0,1,2,8,16},
		{256,0,1,2,8,16},{257,0,1,2,8,16},{258,0,1,2,8,16},{259,0,1,3,8,19},{260,0,1,2,8,16},{261,0,1,2,5,16},{262,0,1,3,6,19},{263,0,1,2,8,16},{264,0,1,2,6,16},{265,0,2,2,10,16},{267,0,1,2,8,16},{268,0,1,2,8,16},{269,0,1,3,8,19},{270,0,1,3,8,19},{271,0,1,2,7,16},
		{448,0,1,2,8,16},{449,0,1,2,7,16},{450,0,1,2,8,16},{451,0,1,2,8,16},{452,0,2,2,10,16},{454,0,1,2,8,16},{455,0,1,3,8,19},{456,0,1,2,8,16},{457,0,1,2,3,16},{458,0,1,2,3,16},{459,0,1,2,7,16},{460,0,1,2,3,16},{461,0,1,2,7,16},{462,0,1,2,3,16},{463,0,1,2,6,16},
		{640,0,1,2,8,16},{641,0,1,2,6,16},{642,0,1,2,8,16},{643,0,1,2,8,16},{644,0,1,2,8,16},{645,0,1,2,8,16},{646,0,1,2,8,16},{647,0,1,2,8,16},{648,0,1,2,8,16},{649,0,1,2,8,16},{650,0,1,2,3,16},{651,0,1,2,7,16},{652,0,1,2,8,16},{653,0,2,2,12,16},{655,0,1,2,8,16}
	}

-- this could be useful for compression later
font = {}
chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!\'+,-./0123456789:=?# "

-- the rle decoder
function tomemrle(str)
  local o=tonumber(str:sub(1,5),16) -- get (o)ffset
  local w=tonumber(str:sub(6,7),16)*8-1 -- get (w)idth
  local e=str:sub(8,str:len()) -- remove header to get (e)ncoded data
  local d = "" -- (d)ecoded data
  for m, c in e:gmatch("(%u+)([^%u]+)") do -- decode rle, (m)atch & (c)ounter
    d = d .. m .. (m:sub(-1):rep(c))  
  end
  local y=0
  for x = 1,#d,1 do -- write to mem
    local c=string.byte(d:sub(x,x))-65 -- get (c)olor value
    poke4(o+y,c) y=y+1
    if y>w then y=0 o=o+1024 end
  end
end

function font_init()
	for i=1,#fontd do
		font[string.sub(chars,i,i)] = fontd[i]
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


return function()
    -- initialize
    tomemrle(rle)
    font_init()
end

end

rift_effectsunbeat=function()
-- was: effect index = 2

-- #TODO: Figure out palette integration!

return {
	id='sun_beat',
	boot=function()
	end,
	draw=function(control, params, t)
		if(t%1>=0.95) then
			for y=0,136 do 
				for x=0,240 do
					pix(x,y,((pi*atan2(x-120,y-68))+t)%4+1)
				end 
			end 
			circ(120,68,50+5*sin(t/150),15)
		end
	end,
}

end

rift_modifierpostsquares=function()
-- Was: modifier index = 11

local PSp={x=0,y=0,sx=10,sy=10,t=0.02,lt=0}

return {
	id='post_squares',
	draw=function(amount, control, params, t)
		if abs(t-PSp.lt) >= PSp.t then
			PSp.lt = t
			local grid = 240/PSp.sx
			PSp.x=(rand(grid//1)-1)*PSp.sx
			grid=136/PSp.sy
			PSp.y=(rand(grid//1)-1)*PSp.sy
		end

		for i=PSp.x,PSp.x+PSp.sx do
			for j=PSp.y,PSp.y+PSp.sy do
				pix(i,j,clamp(pix(i,j)-control,0,15))
			end
		end
	end,
}

end

rift_paletteoverbrown=function()
-- was: palette index 1

local palette = {}

return {
	id="over_brown",
	boot=function()
		for i=0,15 do
			palette[i*3]=min(255,20+i*32)
			palette[i*3+1]=min(255,10+i*24)
			palette[i*3+2]=i*17
		end
	end,
	get=function(y, t)
		return palette
	end,
}

end

rift_effectcloudtunnel=function()
-- was: effect index = 7
return {
	id='cloud_tunnel',
	boot=function()
	end,
	draw=function(control, params, t)
		local ifft=params.mid
		for i=0,32639 do
			local x,y=i%240-120,i//240-68
			local s,c=sin(t),cos(t)
			local k=(x*s-y*c)%40-20
			local l=(y*s+x*c)%40-20
			local d=(x*x+y*y)^.5
			local a=atan2(y,x)
			local e=(k*k+l*l)^.5
			local c=((99/d)*(e/30+s+ifft)-a*2.55)%8+control
			poke4(i,c)
		end
	end,
}

end

rift_modifiergriddim=function()
-- Was: modifier index = 3

return {
    id='grid_dim',
    draw=function(amount, control, params, t)
        local i=0
        for y=-1,36 do
            for x=-1,60 do
                i=i+1
                --if i > amount*5 then return end
                local sx, sy=x*4+(t*20)%4, y*4+(t*5)%4
                pix(sx,sy,clamp(pix(sx,sy)-control,0,15))
            end
        end
    end,
}

end

rift_modifierrothorz=function()
-- Was: modifier index = 8

return {
	id='rot_horz',
	draw=function(amount, control, params, t)
		local dir=1
		local pixels = 0
		if control == 0 then
			pixels = t%5//1
		else
			if control < 0  then
				dir = -1
			end
			
			--pixels = abs((control*t)%120)
			--pixels = (abs(control)*t)%120
			pixels = (abs(control)*(t+1)//1)%120
		end

		if dir ==1 then
			-- going right
			for y=0,135 do
				-- take the whole line
				memcpy(0x8000,y*120, 120)

				-- put it back in two sections
				memcpy(y*120+pixels,0x8000, 120-pixels)
				memcpy(y*120,0x8000+(120-pixels), pixels)
			end
		else
			-- going left
			for y=0,135 do
				-- take the whole line
				memcpy(0x8000,y*120, 120)

				-- put it back in two sections
				memcpy(y*120+(120-pixels),0x8000, pixels)
				memcpy(y*120,0x8000+pixels, 120-pixels)
			end
		end
	end,
}

end

rift_debugfakefft=function()
if fft == nil then
    -- Not great =^D
    function fft(v)
        return (0.5+(sin(v)^2)*.5)/v
    end
end

end

rift_overlayspiral=function()
-- was: overlay index = 7

return {
	id="spiral",
	boot=function()
	end,
	draw=function(control, params, t)
		local tt=t*30
		for i=0,200 do
			local j=(i/10+tt)%120
			local i2=i/20
			i2=i2*i2
			local z=j+i2
			local X,Y=sin(j)*z,cos(j)*z
			circ(120+X,68+Y,z/10-control*2,clamp(15*j/120,0,15))
		end
	end,
}

end

-- title:  goto80 lovebyte2024
-- author: mantratronic + ps
-- desc:   vj80
-- script: lua


local GigSetup=rift_gig20240210lovebytepsgoto80()

rift_codemath()
rift_codedraw()
rift_codepalette()
rift_codeglobals()
rift_codestate()
rift_codescn()
rift_debugfakefft()
FontBoot=rift_codefont()

Texts={
	{"HIGH", "RAPID", "VOTE!"},
	{"FUNNY", "NICE", "CODE"},
	{"COOL", "KRAZY", "GFX"},
}

-- effects follow the template: {boot=function(), draw=function(), bdr=function()}
Effects={
	rift_effectvoltest(),
	rift_effecttwistfft(),
	rift_effectsunbeat(),
	--  rift_effectfujitwist(),
	rift_effectattunnel(),
	rift_effectquup(),
	rift_effecttunnelwall(),
	rift_effectcloudtunnel(),
	rift_effectswirltunnel(),
	rift_effectchladni(),
	rift_effectcirclecolumn(),
	rift_effectbrokenegg(),
	rift_effectparaflower(),
	rift_effectfftcirc(),
	rift_effectproxima(),
	rift_effectlemons(),
	rift_effectrevisionback(),
	rift_effectbitnick(),
	rift_effectworms(),
}

-- overlays follow the template: {id='', boot=function(), draw=function(), bdr=function()}
Overlays = {
	rift_overlaybobs(),
	rift_overlayjoydivision(),
	rift_overlaylinecut(),
	rift_overlayrevisiontop(),
	rift_overlaysinebobs(),
	rift_overlaysmileyfaces(),
	rift_overlaysmokecircles(),
	rift_overlaysnow(),
	rift_overlayspiral(),
	rift_overlaystickerlens(),
	rift_overlaytextbounceup(),
	rift_overlaytextwarp(),
}

Modifiers={
	rift_modifierpixnoise(),
	rift_modifierpixzoom(),
	rift_modifiergriddim(),
	rift_modifierpostcirc(),
	rift_modifierpixmotionblur(),
	rift_modifierpixjumpblur(),
	rift_modifierrotvert(),
	rift_modifierrothorz(),
	rift_modifiersftvert(),
	rift_modifiersfthorz(),
	rift_modifierpostsquares(),
	rift_modifierlinescratch(),
}

Palettes = {
	rift_palettesweetie16(),
	rift_paletteblueorange(),
	rift_palettereddish(),
	rift_palettepastels(),
	rift_palettedutch(),
	rift_palettebluegreysine(),
	rift_palettegreyscale(),
	rift_palettedimmed(),
	rift_paletteoverbrown(),
	rift_paletteslowwhite(),
	rift_paletteinverted(),
	rift_paletteukr(),
	rift_palettetrans(),
	rift_paletteeire(),
}


local TicFn = nil

EffectsLookup={}
OverlaysLookup={}
ModifiersLookup={}
PalettesLookup={}
PalettesLookupCount = 0

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

function ModifierHandler(iModifier, control, params, t)
	local modifier = Modifiers[iModifier]
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


-- Palettes

PAL_STATE=0 -- 1: changing, 0: static, -1:perline
PAL_MOD=0 -- 0: done
PAL_CURRENT=0

function PAL_BOOT()
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


function PAL_Fade(ip,l)
 local lm=68-abs(68-l)
 for i=0,47 do
  poke(0x3fc0+i, clamp(ip[i]*lm/5.5,0,255))
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

		-- #TODO: sure there's better :)
		for keycode=27,36 do
			if keyp(keycode) then
				triggerNumberShortcut(keycode-27)
			end
		end

		-- left: increase 3d logo
		if keyp(60) then
			OL_ID = OL_ID + 1
		end

		-- right: decrease 3d logo
		if keyp(61) then
			OL_ID = OL_ID - 1
		end

		-- #TODO: put this back in...
		--  OL_ID = clamp(OL_ID%(#OldLogos+1),1,#OldLogos)

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
		LBT=T
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
		if TextID < 1 then
			TextID = #Texts
		end
	end

	-- right: increase text image
	if keyp(61) then
		TextID = TextID + 1
		if TextID > #Texts then
			TextID = 1
		end
	end

 --TextID = clamp(TextID%(#Texts+1),1,#Texts)
  
	-- insert: effect cls switch
	if keyp(53) == true then
		ECLS = not ECLS
	end

	-- pageup: effect modifier order switch
	if keyp(54) == true then
		EOrder = 1 - EOrder -- 0 <-> 1
	end

	-- q: effect down
	if keyp(17) == true then
		Effect = Effect - 1
		if Effect < 1 then
			Effect = #Effects
		end
	end

	-- w: effect up
	if keyp(23) == true then
		Effect = Effect + 1
		if Effect > #Effects then
			Effect = 1
		end
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
	ETimerMode = clamp(ETimerMode,0,TM_MAX)

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
	-- p: effect palette up
	local oldPalette = EPalette
	EPalette = (EPalette - (keyp(15) and 1 or 0) + (keyp(16) and 1 or 0)) % PalettesLookupCount
	if oldPalette ~= EPalette then
		SCN0:setPalette(Palettes[EPalette + 1])
	end
	
	-- 1: effect modifier down
	if keyp(28) == true then
		EModifier = EModifier - 1
		if EModifier < 1 then
			EModifier = #Modifiers
		end
	end

	-- 2: effect modifier up
	if keyp(29) == true then
		EModifier = EModifier + 1
		if EModifier > #Modifiers then
			EModifier = 1
		end
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
	EMTimerMode = clamp(EMTimerMode,0,TM_MAX)

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
		if OModifier < 1 then
			OModifier = #Modifiers
		end
	end

	-- x: overlay modifier up
	if keyp(24) == true then
		OModifier = OModifier + 1
		if OModifier > #Modifiers then
			OModifier = 1
		end
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
  
 	OMTimerMode = clamp(OMTimerMode,0,TM_MAX)
  
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
		if Overlay < 1 then
			Overlay = #Overlays
		end
	end

	-- s: overlay up
	if keyp(19) == true then
		Overlay = Overlay + 1
		if Overlay > #Overlays then
			Overlay = 1
		end
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

	OTimerMode = clamp(OTimerMode,0,TM_MAX)

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
	-- ;: overlay palette up
	local oldPalette = OPalette
	OPalette = (OPalette - (keyp(12) and 1 or 0) + (keyp(42) and 1 or 0)) % PalettesLookupCount
	if oldPalette ~= OPalette then
		SCN1:setPalette(Palettes[OPalette + 1])
	end

	-- delete: overlay cls switch
	if keyp(52) == true then
		OCLS = not OCLS	-- false <-> true
	end

	-- pagedown: effect modifier order switch
	if keyp(55) == true then
		OOrder = 1 - OOrder -- 0 <-> 1
	end

	-- backslash: debug switch
	if keyp(41) == true then
		cls()
		DEBUG = not DEBUG	-- false <-> true
	end

	-- backspace: exit
	--if keyp(51) == true then
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

	for _,palette in ipairs(Palettes) do
		if palette.boot then
			palette.boot()
		end
	end

	setAvailableEffectsAll()
	setAvailableOverlaysAll()
	setAvailableModifiersAll()
	setAvailablePalettesAll()

	-- We can override avaliable effects, overlays, and modifiers
	-- And also set up our number shortcuts
	GigSetup.boot()

	SCN0 = Scn:new(Palettes[EPalette+1])
	SCN1 = Scn:new(Palettes[OPalette+1])
	
	TicFn = TICstartup
end

function TICstartup()
	cls()
	print("VJ80",105,0,12)

	if keyp(48) then
		TicFn = TICvj
	end

	for i,effect in ipairs(Effects) do
		print(effect.id,0,8+i*6,13)
	end

	for i,overlay in ipairs(Overlays) do
		print(overlay.id,60,8+i*6,13)
	end

	for i,modifier in ipairs(Modifiers) do
		print(modifier.id,120,8+i*6,13)
	end

	for i,palette in ipairs(Palettes) do
		print(palette.id,180,8+i*6,13)
	end

	print("Space to start", 80,128,12)
end

T=0
function TICvj()
	poke(0x3ffb,4)	-- remove mouse pointer but doesn't
	
	T=time()
 
 	vbank(0)

	local bt=((T-LBT))/(BT)
	if EStutter == 1 and SBT ~= bt//1 then
		ECLS = not ECLS
	end

	if OStutter == 1 and SBT ~= bt//1 then
		OCLS = not OCLS
	end

	SBT = bt//1

	if ECLS then 
		cls()
	end

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
 
	if EOrder == 0 then
		ModifierHandler(EModifier, EMControl, params, emt)
	end

	local effect = Effects[Effect]
	if effect then
		effect.draw(EControl, params, et)
	end
 
	if EOrder == 1 then
		ModifierHandler(EModifier, EMControl, params, emt)
	end

	vbank(1)
	if OCLS then 
		cls()
	end
 
	if OOrder == 0 then
		ModifierHandler(OModifier, OMControl, params, omt)
	end

	local overlay = Overlays[Overlay]
	if overlay then
		overlay.draw(OControl, params, ot)
	end

	if OOrder == 1 then
		ModifierHandler(OModifier, OMControl, params, omt)
	end

 --[[if DEBUG == true then
  print("Effect: "..Effect.."|Ctrl: "..EControl.."|Timer: "..ETimerMode.."|Sped: "..EDivider.."|Pal: "..EPalette,0,100,12)
  print("EModifier: "..EModifier.."|Ctrl: "..EMControl.."|Timer: "..EMTimerMode.."|Sped: "..EMDivider.."|ET:"..ET,0,108,12)
  print("Overlay: "..Overlay.."|Ctrl: "..OControl.."|Timer: "..OTimerMode.."|Sped: "..ODivider.."|Pal: "..OPalette,0,116,12)
  print("OModifier: "..OModifier.."|Ctrl: "..OMControl.."|Timer: "..OMTimerMode.."|Sped: "..OMDivider,0,124,12)
 end--]]
 
	if DEBUG == true then
		if EModifier >= 1 then
			print(Modifiers[EModifier].id.."|"..EMControl.."|"..EMTimerMode.."|"..EMDivider,0,100,12)
		end
		print(Effects[Effect].id.."|"..EControl.."|"..ETimerMode.."|"..EDivider.."|"..Palettes[EPalette+1].id,0,108,12)
		if Overlay >= 1 then
			print(Overlays[Overlay].id.."|"..OControl.."|"..OTimerMode.."|"..ODivider.."|"..Palettes[OPalette+1].id,0,116,12)
		end
		if OModifier >= 1 then
			print(Modifiers[OModifier].id.."|"..OMControl.."|"..OMTimerMode.."|"..OMDivider,0,124,12)
		end
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

-- Configuration

function setTexts(texts)
	Texts = texts
end

-- Put all the effects into the EffectsLookup table...
function setAvailableEffectsAll()
	EffectsLookup = {}
	for index,effect in ipairs(Effects) do
		EffectsLookup[effect.id] = index
	end
end	

-- Put all the specified effects (a table of ids) into the EffectsLookup table...
--[[
function setAvailableEffects(effectIDs)
	EffectsLookup = {}
	for _,id in ipairs(effectIDs) do
		for _,effect in ipairs(effectIDs) do
			if id == effect.id then
			end
		end
	end
end
--]]

function setAvailableOverlaysAll()
	OverlaysLookup = {}
	for index,overlay in ipairs(Overlays) do
		OverlaysLookup[overlay.id] = index
	end
end	

function setAvailableModifiersAll()
	ModifiersLookup = {}
	for index,modifier in ipairs(Modifiers) do
		ModifiersLookup[modifier.id] = index
	end
end	

function setAvailablePalettesAll()
	PalettesLookup = {}
	PalettesLookupCount = 0
	for index,palette in ipairs(Palettes) do
		PalettesLookup[palette.id] = index
		PalettesLookupCount = PalettesLookupCount + 1
	end
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

