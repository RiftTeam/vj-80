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
    twist=Fuji_numframes*(1+it+BASS*EControl*cos(y/Fuji_height))/2
    dl=frames[twist//1%Fuji_numframes+1]
    for i=1,#dl do
     ln=dl[i]
     if ln[2] == y then  
      line(120+ln[1],ln[2]+bnc,120+ln[3],ln[4]+bnc,ln[5])
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