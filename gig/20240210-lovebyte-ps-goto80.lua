return {
	-- #TODO: This might get renamed...
	boot=function()
		setTexts({
			{"LOVEBYTE","2024","+ + +","GOTO80","+ + +"},
			{"ACID","DANCE","ROBOT","NINJA"},
			{"LOVE","LIFE","LIVE","LEFT","LOUD","LINE"},
			{"MATH","SINE","CIRC","LINE","CLS","RECT"},
			{"MUNCH","---"},
			{"I","DONT","KNOW"},
			{"SHALALA","---"},
			{"HARDCORE","FAMILY"},
			{"BREAK","BEAT","DANCE","HIT","HOP","SHOUT","SCREAM","JUMP"},
		})

		setEffects({
			require("effect/vol_test"),
			require("effect/twist_fft"),
			require("effect/sun_beat"),
			--  require("effect/fuji_twist"),
			require("effect/at_tunnel"),
			require("effect/quup"),
			require("effect/tunnel_wall"),
			require("effect/cloud_tunnel"),
			require("effect/swirl_tunnel"),
			require("effect/chladni"),
			require("effect/circle_column"),
			require("effect/broken_egg"),
			require("effect/para_flower"),
			require("effect/fft_circ"),
			require("effect/proxima"),
			require("effect/lemons"),
			require("effect/revision_back"),
			require("effect/bitnick"),
			require("effect/worms"),		
		})

		setOverlays({
			require("overlay/bobs"),
			require("overlay/joy_division"),
			require("overlay/line_cut"),
			require("overlay/revision_top"),
			require("overlay/sinebobs"),
			require("overlay/smiley_faces"),
			require("overlay/smoke_circles"),
			require("overlay/snow"),
			require("overlay/spiral"),
			require("overlay/sticker_lens"),
			require("overlay/text_bounce_up"),
			require("overlay/text_warp"),			
		})

		setModifiers({
			require("modifier/pix_noise"),
			require("modifier/pix_zoom"),
			require("modifier/grid_dim"),
			require("modifier/post_circ"),
			require("modifier/pix_motion_blur"),
			require("modifier/pix_jump_blur"),
			require("modifier/rot_vert"),
			require("modifier/rot_horz"),
			require("modifier/sft_vert"),
			require("modifier/sft_horz"),
			require("modifier/post_squares"),
			require("modifier/line_scratch"),		
		})
		--[[
		setModifiers({
			'pix_noise', 'pix_zoom', 'grid_dim',	'post_circ', 'pix_motion_blur', 'pix_motion_blur',
			'pix_jump_blur', 'rot_vert',	'rot_horz', 'sft_vert', 'sft_horz', 'post_squares',
		})
		--]]

		setPalettes({
			require("palette/sweetie_16"),
			require("palette/blue_orange"),
			require("palette/reddish"),
			require("palette/pastels"),
			require("palette/dutch"),
			require("palette/blue_grey_sine"),
			require("palette/grey_scale"),
			require("palette/dimmed"),
			require("palette/over_brown"),
			require("palette/slow_white"),
			require("palette/inverted"),
			require("palette/ukr"),
			require("palette/trans"),
			require("palette/eire"),		
		})

		setNumberShortcut(1, function()
			setEffect('sun_beat', {timerMode=3, divider=1, palette='reddish', stutter=0, modifier=0, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('smoke_circles', {timerMode=1, divider=1, palette='eire', control=2, stutter=0, modifier=1, cls=false})
		end)

		setNumberShortcut(2, function()
			setEffect('lemons', {timerMode=1, divider=1, palette=5, stutter=0, modifier=5, modControl=1, modTimerMode=1, modDivider=1, cls=true})
			setOverlay('text_warp', {timerMode=4, divider=6, palette=7, control=13, stutter=0, modifier=5, cls=true})
		end)

		setNumberShortcut(3, function()
			setEffect('twist_fft', {timerMode=1, divider=1, palette=7, stutter=0, modifier=6, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('text_bounce_up', {timerMode=1, divider=1, palette=5, control=2, stutter=0, modifier=7, cls=true})
		end)

		setNumberShortcut(4, function()
			setEffect('quup', {timerMode=1, divider=1, palette='reddish', stutter=0, modifier=11, modControl=33, modTimerMode=4, modDivider=1, cls=false})
			setOverlay('bobs', {timerMode=1, divider=1, palette=6, control=2, stutter=0, modifier=11, cls=false})
		end)

		setNumberShortcut(5, function()
			setEffect('at_tunnel', {timerMode=1, divider=1, palette='sweetie_16', stutter=0, modifier=13, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('spiral', {timerMode=2, divider=6, palette=10, control=3, stutter=0, modifier=13, cls=false})
		end)

		setNumberShortcut(6, function()
			setEffect('worms', {timerMode=2, divider=5, palette='over_brown', stutter=0, modifier=12, modControl=1, modTimerMode=1, modDivider=1, cls=true})
			setOverlay('line_cut', {timerMode=1, divider=1, palette='ukr', control=1, stutter=0, modifier=2, cls=true})
		end)

		setNumberShortcut(7, function()
			setEffect('quup', {timerMode=2, divider=1, palette='ukr', stutter=0, modifier=11, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('smiley_faces', {timerMode=1, divider=1, palette=7, control=15, stutter=0, modifier=2, cls=true})
		end)

		setNumberShortcut(8, function()
			setEffect('bitnick', {timerMode=1, divider=1, palette='over_brown', stutter=0, modifier=12, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('sinebobs', {timerMode=3, divider=5, palette=9, control=1, stutter=0, modifier=6, cls=true})
		end)

		setNumberShortcut(9, function()
			setEffect('at_tunnel', {timerMode=5, divider=3, palette='grey_scale', stutter=0, modifier=13, modControl=1, modTimerMode=1, modDivider=1, cls=true})
			setOverlay('bobs', {timerMode=1, divider=1, palette='eire', control=1, stutter=0, modifier=12, cls=false})
		end)

		setNumberShortcut(0, function()
			setEffect('worms', {timerMode=1, divider=1, palette=7, stutter=0, modifier=7, modControl=0, modTimerMode=3, modDivider=0, cls=false})
			setOverlay('sticker_lens', {timerMode=3, divider=1, palette=5, control=1, stutter=0, modifier=13, cls=true})
		end)
	end,
}

-- #TODO: I don't think this one made it...
--  setEffect('revision_back', {timerMode=5, divider=6, palette=1, stutter=0, modifier=3, modControl=1, modTimerMode=1, modDivider=1, cls=false})
--  setOverlay('bobs', {timerMode=8, divider=0, palette=13, control=4, stutter=0, modifier=1, cls=true})
