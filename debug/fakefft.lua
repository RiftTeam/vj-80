if fft == nil then
    -- Not great =^D
    function fft(v)
		local t = (time()%1000)/1000
        return 0.7+((sin(v+t*.001)^2)*.3)
    end
end