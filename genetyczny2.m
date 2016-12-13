genCount = 100;
initialArray = [9,2,3,4,1,16,5,7,8,10,12,13]
sortArrayLen = length(initialArray);
genes = [];
killRate = 0.1;
crossOverRate = 0.5; %half of genes will be crossed(0-1)
mutationRate = 0.1;
targetFitness = 1/sortArrayLen
sizeOfElite = 5 %how many best genoms won't be taken for crossover

%create matrix where every row is one gene first column is fitness score, creating initial population
for c=1:genCount
    gen = initialArray(randperm(length(initialArray)));
    genFitness = fitnessFunction(gen);
    gen = [genFitness gen];
    genes = [genes; gen];
end

acc = [];
for time=1:10000
    %we need to sort matrix by fitness score the lower the better
    genes = sortrows(genes, 1);
    %calculate sum of all fitness scores to pick genes for crossover
    fitnessSum = sum(genes(1:genCount, 1));
    %offspring generation
    genes2 = []; %create second array for offspring
    for c=1:round(genCount*crossOverRate)
        
        tempSum =0;
            firstGenNumber = rand*fitnessSum;
            secondGenNumber = rand*fitnessSum;
            for d=1:genCount
                tempSum = tempSum+genes(d, 1);
                if(tempSum>firstGenNumber)
                    firstGenNumber = d;
                    break;
                end
            end
            tempSum =0;
            d=0;
            for d=1:genCount
                tempSum = tempSum+genes(d, 1);
                if(tempSum>secondGenNumber)
                    secondGenNumber = d;
                    break;
                end
            end
        if(firstGenNumber>sizeOfElite+1 & secondGenNumber>sizeOfElite+1) %if we are below elite we take first after elite
            A = crossOver3(genes(firstGenNumber, 2:end), genes(secondGenNumber, 2:end));
            genes2 = [genes2; A]; %genes2 array doesn't have fitness score
        else
            A = crossOver3(genes(sizeOfElite+1, 2:end), genes(sizeOfElite+2, 2:end));
            genes2 = [genes2; A]; %genes2 array doesn't have fitness Score
        end
    end

    %mutation
    for c=1:size(genes2, 1)
        if(rand<mutationRate)
            mutate(genes2(c, 1:end));
        end
    end

    %rewrite mutation table from genes2 to genes and add FitnessScore
    for c=sizeOfElite+1:size(genes2 ,1)
        genFitness = fitnessFunction(genes2(c, 1:end));
        gen = [genFitness genes2(c, 1:end)];
        genes = [genes; gen];
    end
    
    genes = sortrows(genes, 1);
    
    howManyKill = size(genes,1) - genCount + round(size(genes,1)*killRate); %calculate how many kill
    j=size(genes,1);
    for c=1:howManyKill
        genes(j+1-c, :) = [];
    end

    howManySpawn = genCount - size(genes,1);
    %spawn new ones to fill society
    for c=1:howManySpawn
        gen = initialArray(randperm(length(initialArray)));
        genFitness = fitnessFunction(gen);
        gen = [genFitness gen];
        genes = [genes; gen];
    end
    genes = sortrows(genes, 1);
    
    %plot data
    acc = [acc genes(1,1)];
    
    %calculation end statement
    if(genes(1,1)==(1/sortArrayLen))
        break;
    end
end
figure
plot(acc)
title('fit score over generations')
xlabel('generation number')
ylabel('fitscore')
legend('best fit score')
