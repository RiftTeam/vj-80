--[[
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

 if OControl~=0 and JD_ot%OControl == 0 then
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
--]]