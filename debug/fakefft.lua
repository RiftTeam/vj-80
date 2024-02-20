if fft == nil then
    -- Not great =^D
    function fft(v)
        return (0.5+(sin(v)^2)*.5)/v
    end
end