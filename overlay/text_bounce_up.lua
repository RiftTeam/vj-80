-- was: overlay index = 1

return {
  id="text_bounce_up",
  boot=function()
  end,
  draw=function(data)
    local it,ifft=data.ot,data.ot
    
    if ODivider ~= 0 then
      tt=t/BT//ODivider
      tx=abs(tt)%#Texts[TextID] + 1
      y=140-160*(it%1)
     else
      tt=t/BT//1
      tx=abs(tt)%#Texts[TextID] + 1
      -- count how many line breaks
      linecount=1
      for i=1, #Texts[TextID][tx] do
        if string.sub(Texts[TextID][tx],i,i) == "\n" then linecount=linecount+1 end
      end
      y=68 - (3+OControl)*3 *linecount
     end
     tc=clamp(MID*15,8,15)
     tl=flength(Texts[TextID][tx],1,OControl)
     fprint(Texts[TextID][tx],120-tl/2,y,1,1,15,OControl)
    end,
}
