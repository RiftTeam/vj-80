-- was: effect index = 9
local ChN=2000
local ChNP=3
local ChV=0.5
local ChPV=-.2
local Chd=1
local ChPX={}
local ChPY={}
local ChT=0 
local ChTT=0
local ChPTX={}
local ChPTY={}
local Chfreq=.75
local ChNPKD = 15

function ChResetPoints(it)
  for i=1,ChNP do
    ChPTX[i]=120-ChNPKD/2+ChNPKD*i/3+30*sin(it/20+ i/ChNP * 2 * pi)
    ChPTY[i]=68-ChNPKD/2+ChNPKD*i/3+26*cos(it/20+i/ChNP * 2 * pi)
  end
end


return {
  id='chladni',
  boot=function()
    ChResetPoints(0)
    for i=1,ChN do
      ChPX[i] = rand(240);
      ChPY[i] = rand(136);
    end
  end,
  draw=function(data)
    local it=data.et
    local ifft=data.bass

    ChT=it--ChT+.2
    ChTT=(it*10)//1--ChTT+1
    ChResetPoints(it)
    
    if ChTT%100 == 0 then
     ChNP = 3 + EControl*rand()
     Chfreq = .3 + rand()
     ChNPKD = 10 + 30*rand()
     Chladni_BOOT()
    end
   
    for i=1,ChN do
     R=0
     D=0
     C=0
     for j=1,ChNP do
      sx = ChPTX[j]
      sy = ChPTY[j]
      
      L=math.sqrt((ChPX[i]-sx)^2 + (ChPY[i]-sy)^2)
      C=C + sin(tau*Chfreq*(ChT-(L/ChV))/60)
   
      L=math.sqrt((ChPX[i]+d-sx)^2 + (ChPY[i]-sy)^2)
      R=R + sin(tau*Chfreq*(ChT-(L/ChV))/60)
   
      L=math.sqrt((ChPX[i]-sx)^2 + (ChPY[i]+Chd-sy)^2)
      D=D + sin(tau*Chfreq*(ChT-(L/ChV))/60)
     end
     C=math.abs(C)
     R=math.abs(R)
     D=math.abs(D)
    
     circ(ChPX[i],ChPY[i],4-C*2,(1.5-C)*10)
     
     L=math.sqrt((R-C)^2 + (D-C)^2)
     
     ChPX[i]=ChPX[i] + (ChPV * (R-C)/L)
     ChPY[i]=ChPY[i] + (ChPV * (D-C)/L)
     
     if ChPX[i] < 0 or ChPX[i] > 240 or ChPY[i] < 0 or ChPY[i] > 136 or C <0.0025 then
      ChPX[i] = rand(240);
      ChPY[i] = rand(136);
     end 
    end
    
    for i=1,ChNP do
     line(ChPTX[i],ChPTY[i]-2,ChPTX[i],ChPTY[i]+2,15)
     line(ChPTX[i]-2,ChPTY[i],ChPTX[i]+2,ChPTY[i],15)
     --circ(ChPTX[i],ChPTY[i],4,15)
    end
  end,
}
