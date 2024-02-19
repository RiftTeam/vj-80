FFTCirc = 13
FC_osize=20

function FFTCirc_DRAW(it,ifft)
  size=FC_osize+ifft*2 + EControl

  tt=it
  for t=0,255 do
   a=(t/255+tt)*tau
   k=t//3
   c=((FFTH[(k-1)%256]+FFTH[(k+1)%256])/2+FFTH[k])*600*((k/255)*1.5+.015)

   x=(size)*sin(a)
   y=(size)*cos(a)
   x1=(size+c/4*EControl)*sin(a)
   y1=(size+c/4*EControl)*cos(a)
   --pix(120+x,68+y,1+c)
   line(120+x,68+y,120+x1,68+y1,1+min(14,c))
  end
end