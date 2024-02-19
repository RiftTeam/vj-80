-- Was: modifier index = 2

return {
    id='pix_zoom',
    draw=function(data)
        local amount,mc=data.amount,data.mc

        local d=1+2*rand()
        for i=1,amount do
            x=240*rand()
            y=136*rand()
            a=math.atan(x-120,y-68)

            op=pix(x,y)-mc
            if op >= 0 then
                pix(x+d*(sin(a)+sin(t/300)),y+d*(cos(a)+sin(t/300)),op)
            else
                pix(x+d*sin(a),y+d*cos(a),0)
            end
        end
    end,
}