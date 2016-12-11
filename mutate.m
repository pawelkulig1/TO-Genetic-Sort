function [ genome ] = mutate( genome )
    poz1 = ceil(rand*length(genome));
    poz2 = ceil(rand*length(genome));
    
    temp = genome(poz1);
    genome(poz1) = genome(poz2);
    genome(poz2) = temp;
end

