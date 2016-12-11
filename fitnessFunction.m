function [ fitness ] = fitnessFunction( genom )
    fitness = 1;
    length(genom);
    for c=1:length(genom)-1
        if genom(c)<genom(c+1)
            fitness = fitness + 1;
        else
            break
        end
    end
    
    fitness = 1/fitness;
            
end

