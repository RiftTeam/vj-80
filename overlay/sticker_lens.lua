--[[
StickerLens = 11
function StickerLens_BOOT()
end
 
function StickerLens_DRAW(it,ifft)
  -- draw point data to spritesheet
  -- first blank
  --memset(0x4000,0,120*136)

  size=100+40*BASS
  hs=size/2
  TWp = TImages[clamp(TIimageID,1,#TImages)]
  for i=1,#TWp do
   p=TWp[i]

   x=(p[1]-120)/OControl
   y=(p[2]-68)/OControl
   c=clamp(FFTH[p[5]//1]*50*(.05 + p[5]/10)+it,0,15)
   a=p[4]
   d=p[5]/OControl

   b=BASS/5
   --focal=(d/(hs*it%2))^(b)
   focal=1+sin(d/20+it/20)*(b+it%1/2)
   d=d*focal--*(it%1+.5)

   ix=d*sin(a)
   iy=d*cos(a)

   if d < size then
    ox=ix+120
    oy=iy+68
    if ox >=0 and ox<240 and oy>=0 and oy<136 then
     pix(ox,oy,c)
    end
  end
 end
end
--]]