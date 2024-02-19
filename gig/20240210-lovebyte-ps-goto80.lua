return {
    -- #TODO: This might get renamed...
    boot=function()
        setNumberShortcut(1, function()
            setEffect('sun_beat', {timerMode=3, divider=1, palette=2, stutter=0, modifier=0, modControl=1, modTimerMode=1, modDivider=1, cls=false})
            setOverlay('smoke_circles', {timerMode=1, divider=1, palette=13, control=2, stutter=0, modifier=1, cls=false})
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
            setEffect('quup', {timerMode=1, divider=1, palette=2, stutter=0, modifier=11, modControl=33, modTimerMode=4, modDivider=1, cls=false})
            setOverlay('bobs', {timerMode=1, divider=1, palette=6, control=2, stutter=0, modifier=11, cls=false})
          end)
          
          setNumberShortcut(5, function()
            setEffect('at_tunnel', {timerMode=1, divider=1, palette=0, stutter=0, modifier=13, modControl=1, modTimerMode=1, modDivider=1, cls=false})
            setOverlay('spiral', {timerMode=2, divider=6, palette=10, control=3, stutter=0, modifier=13, cls=false})
          end)
          
          setNumberShortcut(6, function()
            setEffect('worms', {timerMode=2, divider=5, palette=1, stutter=0, modifier=12, modControl=1, modTimerMode=1, modDivider=1, cls=true})
            setOverlay('line_cut', {timerMode=1, divider=1, palette=11, control=1, stutter=0, modifier=2, cls=true})
          end)
          
          setNumberShortcut(7, function()
            setEffect('quup', {timerMode=2, divider=1, palette=11, stutter=0, modifier=11, modControl=1, modTimerMode=1, modDivider=1, cls=false})
            setOverlay('smiley_faces', {timerMode=1, divider=1, palette=7, control=15, stutter=0, modifier=2, cls=true})
          end)
          
          setNumberShortcut(8, function()
            setEffect('bitnick', {timerMode=1, divider=1, palette=1, stutter=0, modifier=12, modControl=1, modTimerMode=1, modDivider=1, cls=false})
            setOverlay('sinebobs', {timerMode=3, divider=5, palette=9, control=1, stutter=0, modifier=6, cls=true})
          end)
          
          setNumberShortcut(9, function()
            setEffect('at_tunnel', {timerMode=5, divider=3, palette=4, stutter=0, modifier=13, modControl=1, modTimerMode=1, modDivider=1, cls=true})
            setOverlay('bobs', {timerMode=1, divider=1, palette=13, control=1, stutter=0, modifier=12, cls=false})
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