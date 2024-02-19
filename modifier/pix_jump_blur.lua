-- Was: modifier index = 6

return {
  id='pix_jump_blur',
  draw=function(data)
    local amount,mt,mc=data.amount,data.mt,data.mc

    size=10+(mt)%5
    limit=100 + mc
    cx=120 cy=68
    tt=BASS%1
    for i=0,tt*50 do
      d=rand()
      d=1-(d^1.5)
      d1=size+d*(limit-tt*10)
      d2=1+d1+tt*10
      a=rand()*tau
      x=d1*sin(a)
      y=d1*cos(a)
      line(cx+(d1)*sin(a),cy+(d1)*cos(a),cx+(d2)*sin(a),cy+(d2)*cos(a),pix(cx+x,cy+y))
    end

    amount = min(amount,500)
    for i=0,amount do
      d=rand()
      d=1-(d^1.5)
      d=d*(size//1+limit*1.5)
      a=rand()*tau
      x=cx+d*sin(a)
      y=cy+d*cos(a)
      if x >= 1 and x <= 239 and y >=1 and y <= 134 then
        pix(cx+(d+1)*sin(a),cy+(d+1)*cos(a),clamp((pix(x,y)+pix(x+1,y+1)+pix(x+1,y-1)+pix(x-1,y+1)+pix(x-1,y-1))/4.8,0,15))
      end
    end
  end,
}