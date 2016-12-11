function [ baby ] = crossOver3( genom1, genom2 )
    len = length(genom1);
    %genom1, genom2
    start = ceil(rand*len);
    stop = start + round(rand*(len-start));
    part = genom1(start:stop);
    fet = genom2;
    for c=1:stop-start+1;
        index = find(fet==part(c));
        fet(index) = [];
    end

    baby = [fet(1:start-1) part];
    baby = [baby fet(start:end)];

end

