-- was: effect index = 0
return {
    id='vol_test',
    boot=function()
    end,
    draw=function(data)
        for i=239,0,-1 do
            for j=0,135 do
                pix(i,j,(pix(i+1,j)))
            end
        end
        line(239,0,239,136,0)

        print("TIME",0,20,3)
        pix(239,20+data.t/1000,3)
        print("TBEAT",0,50,6)
        pix(239,60+data.bt,6)
        print("TBASS",0,80,9)
        pix(239,100+data.bass,9)
        print("TBASSC",0,110,12)
        pix(239,110+data.bassc/100,12)
    end,
}
