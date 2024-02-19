-- Was: modifier index = 1

return {
    id='pix_noise',
    draw=function(data)
      local amount,mc=data.amount,data.mc

        for i=0,amount do
            x=rand(240)-1
            y=rand(136)-1
            pix(x,y,clamp(pix(x,y)-mc,0,15))
        end
    end,
}