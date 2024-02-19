-- Was: modifier index = 4

return {
  id='post_circ',
  draw=function(data)
    local amount,mt,mc=data.amount,data.mt,data.mc

    it=mt*40
    lim = clamp(8+mc,0,15)
    for y=0,135 do 
      for x=0,239 do
        dy=(68-y)
        dx=(120-x)
        d=math.sqrt(dx^2+dy^2)//1
        a=math.atan2(dx,dy)
        if((10*sin(it/4+d/5))%100>50) then
          c=pix(x,y)
          if c>lim then
            pix(x,y,clamp(c-8,0,15))
          end
        end 
      end 
    end
  end,
}