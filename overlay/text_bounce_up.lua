-- was: overlay index = 1
-- Receives a tables of table strings ({"EAT", "MORE", "VEGETABLES"}, {"SNAP", "CRACKLE", "POP"})
-- TODO: newlines (\n) in strings need work in the font functions...
return function(messageGroups)
	local groupID = 1
	return {
		id="text_bounce_up",
		boot=function()
		end,
		draw=function(control, params, t)
			local messageGroup = messageGroups[groupID]
			local tt, message, y
			if params.oDivider ~= 0 then
				-- scroll up
				tt = t/params.bt//params.oDivider
				tt = tt + t -- JTR: Patch to make the text change. This needs fixing!
				message = messageGroup[1 + (abs(tt)//1 % #messageGroup)]
				y = 140-160*(t%1)
			else
				-- static
				tt=t/params.bt//1
				tt = tt + t -- JTR: Patch to make the text change. This needs fixing!
				message = messageGroup[1 + (abs(tt)//1 % #messageGroup)]
				-- count how many line breaks
				local linecount=1

				if not message then
					-- #TODO: I don't think this should be needed, but some value goes wild, so this becomes nil
					-- To debug elsewhere later!
					return
				end
	
				for i=1,#message do
					if message:sub(i,i) == "\n" then
						linecount = linecount+1
					end
				end
				y=68 - (3+control*2)*3*linecount
			end

			if not message then
				-- #TODO: I don't think this should be needed, but some value goes wild, so this becomes nil
				-- To debug elsewhere later!
				return
			end

			local tc=clamp(params.mid*15,8,15)
			local messageW = flength(message,1,control)
			fprint(message,120-messageW/2,y,1,1,15,control)
		end,
	}
end