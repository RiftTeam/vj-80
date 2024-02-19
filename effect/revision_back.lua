-- was effect index = 16

local cubes ={}
local cubeLines = {
    {-1,-1,-1,1,-1,-1},
    {-1,-1,-1,-1,1,-1},
    {-1,-1,-1,-1,-1,1},

    {1,-1,-1,1,1,-1},
    {1,-1,-1,1,-1,1},

    {-1,1,-1,-1,1,1},
    {-1,1,-1,1,1,-1},

    {1,1,-1,1,1,1},

    {-1,1,1,1,1,1},
    {-1,1,1,-1,-1,1},

    {-1,-1,1,1,-1,1},
    {1,1,1,1,-1,1},
}

return {
    id='revision_back',
    boot=function()
        for i = 1,5 do
            for j = 1,16 do
        --      table.insert(cubes,{15*sin(j/16*tau+it+i/13),15*cos(j/16*tau+it+i/13),5+i*4})
            end
          end
        --  cubes[1]={5,5,10}
    end,
    draw=function(data)
        RB_cubes={}
        for i = 1,5 do
          for j = 1,16 do
            table.insert(cubes,{(13+data.bass)*sin((j/16+data.et)*tau+i/15),(13+data.bass)*cos((j/16+data.et)*tau+i/15),10+i*4})
          end
        end
        for i=1,#cubes do
          for j=1,#cubeLines do
            local ln=cubeLines[j]
            
            local x1=(ln[1]+cubes[i][1]) *99/(cubes[i][3]+ln[3])
            local y1=(ln[2]+cubes[i][2])*99/(cubes[i][3]+ln[3])
            local x2=(ln[4]+cubes[i][1])*99/(cubes[i][3]+ln[6])
            local y2=(ln[5]+cubes[i][2]) *99/(cubes[i][3]+ln[6])
            line(x1+120,y1+68,x2+120,y2+68,16-cubes[i][3]/2)
          end
        end
    end,
}
