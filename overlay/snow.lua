-- was: overlay index = 5

return {
	id="snow",
	boot=function()
	end,
	draw=function(control, params, t)
		for i=0,OControl do
			circ(rand(240),rand(136),rand(4),t)
		end
	end,
}
