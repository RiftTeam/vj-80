-- Was: modifier index = 2

return {
    id='pix_zoom',
    draw=function(amount, control, params, t)
        local d=1+2*rand()
        for i=1,amount do
            local x,y = 240*rand(),136*rand()
            local a=atan2(x-120,y-68)

            local op=pix(x,y)-control
            if op >= 0 then
                pix(x+d*(sin(a)+sin(t/300)),y+d*(cos(a)+sin(t/300)), op)
            else
                pix(x+d*sin(a),y+d*cos(a),0)
            end
        end
    end,
}