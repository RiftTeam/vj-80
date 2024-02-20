-- was: overlay index = 1

return {
	id="text_bounce_up",
	boot=function()
	end,
	draw=function(control, params, t)
		if params.oDivider ~= 0 then
			tt=t/BT//params.oDivider
			tx=abs(tt)%#Texts[TextID] + 1
			y=140-160*(t%1)
		else
			tt=t/BT//1
			tx=abs(tt)%#Texts[TextID] + 1
			-- count how many line breaks
			linecount=1
			for i=1, #Texts[TextID][tx] do
				if string.sub(Texts[TextID][tx],i,i) == "\n" then
					linecount=linecount+1
				end
			end
			y=68 - (3+control)*3 *linecount
		end
		local tc=clamp(MID*15,8,15)
		local tl=flength(Texts[TextID][tx],1,control)
		fprint(Texts[TextID][tx],120-tl/2,y,1,1,15,control)
	end,
}
