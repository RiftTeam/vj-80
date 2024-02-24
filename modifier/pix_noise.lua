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