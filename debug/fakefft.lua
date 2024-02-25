if fft == nil then
    -- Not great =^D
    function fft(v)
		local t = (time()%1000)/1000
        return 0.3+((sin(v+t*.001)^3)*.3)
    end
end