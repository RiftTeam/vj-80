return {
	-- #TODO: This might get renamed...
	boot=function()
		setTexts({
			{"LOVEBYTE","2024","+ + +","GOTO80","+ + +"},
		})

		setEffects({
			require("effect/twist_fft"),
		})

		setOverlays({
			require("overlay/bobs"),
		})

		setModifiers({
			require("modifier/pix_noise"),
		})

		setPalettes({
			require("palette/sweetie_16"),
		})
	end,
}
