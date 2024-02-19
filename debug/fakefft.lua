if fft == nil then
    -- Not great =^D
    function fft(v)
        return (0.5+(math.sin(v)^2)*.5)/v
    end
end