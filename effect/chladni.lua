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

function resetPoints(t)
	for i=1,ChNP do
		ChPTX[i]=120-ChNPKD/2+ChNPKD*i/3+30*sin(t/20+ i/ChNP * 2 * pi)
		ChPTY[i]=68-ChNPKD/2+ChNPKD*i/3+26*cos(t/20+i/ChNP * 2 * pi)
	end
end

function resetAll()
	resetPoints(0)
	for i=1,ChN do
		ChPX[i] = rand(240);
		ChPY[i] = rand(136);
	end
end

return {
	id='chladni',
	boot=function()
		resetAll()
	end,
	draw = function(control, params, t)
		ChT = t--ChT+.2
		ChTT = (t*10)//1--ChTT+1

		if ChTT%100 == 0 then
			ChNP = 3 + control*rand()
			Chfreq = .3 + rand()
			ChNPKD = 10 + 30*rand()
			resetAll()
		else
			resetPoints(t)
		end

		for i=1,ChN do
			local R=0
			local D=0
			local C=0
			for j=1,ChNP do
				local sx,sy = ChPTX[j], ChPTY[j]

				local L=sqrt((ChPX[i]-sx)^2 + (ChPY[i]-sy)^2)
				C=C + sin(tau*Chfreq*(ChT-(L/ChV))/60)

				local d=0	-- #TODO: Check what this should be!
				L=sqrt((ChPX[i]+d-sx)^2 + (ChPY[i]-sy)^2)
				R=R + sin(tau*Chfreq*(ChT-(L/ChV))/60)

				L=sqrt((ChPX[i]-sx)^2 + (ChPY[i]+Chd-sy)^2)
				D=D + sin(tau*Chfreq*(ChT-(L/ChV))/60)
			end
			C=abs(C)
			R=abs(R)
			D=abs(D)

			circ(ChPX[i],ChPY[i],4-C*2,(1.5-C)*10)

			L=sqrt((R-C)^2 + (D-C)^2)

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