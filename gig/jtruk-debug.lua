return {
	boot=function()
		setEffects({
--			require("effect/fuji_twist"),
			--require("effect/debug-squares"),
--			require("effect/vol_test"),
			require("effect/twist_fft"),
			require("effect/sun_beat"),
			require("effect/at_tunnel"),
			require("effect/quup"),
--			require("effect/tunnel_wall"),
			require("effect/cloud_tunnel"),
			require("effect/swirl_tunnel"),
			require("effect/chladni"),
			require("effect/circle_column"),
			require("effect/broken_egg"),
			require("effect/para_flower"),
			require("effect/fft_circ"),
--			require("effect/proxima"),
			require("effect/lemons"),
			require("effect/revision_back"),
			require("effect/bitnick"),
			require("effect/worms"),
		})

		setOverlays({
			require("overlay/sticker_lens")({function()
				local sz=3
				local l=flength("TOPLAP20",3,sz)
				fprint("TOPLAP20",120-l/2,38,3,1,12,sz)
			end}),
			require("overlay/bobs"),
--			require("overlay/joy_division"),
			require("overlay/text_bounce_up")({
				{"CREATIVE", "CODE", "CLUB", "NEWCASTLE"},
			}),
			require("overlay/line_cut"),
			require("overlay/revision_top"),
			require("overlay/sinebobs"),
			require("overlay/warp")({function()
				local sz=3
				local l=flength("TOPLAP20",3,sz)
				fprint("TOPLAP20",120-l/2,38,3,1,12,sz)
			end}),
			require("overlay/smiley_faces"),
			require("overlay/smoke_circles"),
			require("overlay/snow"),
			require("overlay/spiral"),
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

		setPalettes({
--			require("palette/sweetie_16"),
			require("palette/grey_scale"),
			require("palette/slow_white"),
			require("palette/blue_orange"),
			require("palette/reddish"),
			require("palette/pastels"),
			require("palette/dutch"),
			require("palette/blue_grey_sine"),
			require("palette/rainbow"),
			require("palette/over_brown"),
			require("palette/dimmed"),
			require("palette/inverted"),
			require("palette/ukr"),
			require("palette/trans"),
			require("palette/eire"),	
		})

		setNumberShortcut(1, function()
			setEffect('sun_beat', {timerMode=3, divider=1, palette='reddish', stutter=0, modifier=nil, modControl=1, modTimerMode=1, modDivider=1, cls=false})
			setOverlay('smoke_circles', {timerMode=1, divider=1, palette='eire', control=2, stutter=0, modifier='pix_noise', cls=false})
		end)
	end,
}
