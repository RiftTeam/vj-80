-- was: effect index = 3

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
  draw=function(data)
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