-- Was effect index = 15

local LE_points={}
local LE_lines={}
local LE_columns={}
local LE_rd={}
local LE_np=15
local LE_nl=15
local LE_nc=5
return {
  id='lemons',
  boot=function()
    for i=1,LE_nl do
      local lp={}
      for j=1,LE_np do
        lp[j]=5*rand()
      end
      LE_rd[i]=lp
      end
  end,
  draw=function(data)
    local it=data.et
    local h=0
    local n=0
  
    numlem = clamp(LE_nc+EControl,1,20)
  
    local ccp={}
    it=it*tau
    for h=1,numlem do
      local a = h/numlem * tau
      ccp[h]={x=100*sin(a+it/7), y=0, z=30*cos(a+it/7), n=h}
    end
    table.sort(ccp, function (a,b) return a.z<b.z end)
    
    
    for h=1,numlem do
      LE_lines={}
      fftl=FFTH
      for i=1,LE_nl do
      local lp={}
      for j=1,LE_np do
        local a = j/LE_np * tau
        local p={x=(20+LE_rd[i][j]+fftl[i]*10)*sin(a+it)*sin(i/LE_nl*math.pi),
                y=(i-(LE_nl/2))*4,
                z=(20+LE_rd[i][j]+fftl[i]*10)*cos(a+it)*sin(i/LE_nl*math.pi)}
        a = it/4+h
        lp[j]={x=p.x*sin(a)-p.y*cos(a),
              y=p.y*sin(a)+p.x*cos(a),
              z=p.z}
      end
      LE_lines[i]=lp
      end
      LE_columns[h]=LE_lines
    end 
    
    for k=1,numlem do
      if ccp[k].z >-23 then
      h=ccp[k].n
      for i=1,LE_nl do
        for j=1,LE_np-1 do
        sp=LE_columns[h][i][j]
        ep=LE_columns[h][i][j+1]
        
        if(sp.z+ep.z)>0 then
          sz=sp.z-100+ccp[k].z
          ez=ep.z-100+ccp[k].z
          sx=120+sp.x*99/sz+ccp[k].x
          sy=68+sp.y*99/sz+ccp[k].y
          ex=120+ep.x*99/ez+ccp[k].x
          ey=68+ep.y*99/ez+ccp[k].y
          line(sx,sy,ex,ey,ez/8)
        end
        --pix(120+sp.x*99/sz,68+sp.y*99/sz,12)
        end
        sp=LE_columns[h][i][LE_np]
        ep=LE_columns[h][i][1]
        if(sp.z+ep.z)>0 then
          sz=sp.z-100+ccp[k].z
          ez=ep.z-100+ccp[k].z
          sx=120+sp.x*99/sz+ccp[k].x
          sy=68+sp.y*99/sz+ccp[k].y
          ex=120+ep.x*99/ez+ccp[k].x
          ey=68+ep.y*99/ez+ccp[k].y
        line(sx,sy,ex,ey,ez/8)
        end
    --  line(minx,miny,maxx,maxy,1)
      end
      end
    end
  end,
}

