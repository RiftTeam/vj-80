-- was: effect index = 17
-- #TODO Check this wasn't an overlay
return {
    id = 'bitnick',
    boot = function()
    end,
    draw = function(control, params, t)
		randseed(2)
		local tt = (t / control)
		for x = 0, 51 do
			local w = rand() * 70 + 30
			local h = rand() * 20 + 10
			local posx = (rand() * 240 + (tt / w * 4) * x / 20) % (240 + w + x) - w
			local posy = rand() * (136 + h) - h
			local col = rand() * 2 + cos(tt / 2000) * 2 + 5

			clip(posx, posy, w, h)
			for i = posx, posx + w do
				circ(i, posy + i // 1 % h, w / (col + 16), col + i / 300)
			end
			clip()
		end
	end,
}
