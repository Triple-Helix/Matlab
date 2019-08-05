clear all;
close all;

len = 36;                    % The length of the genomes   (must be divisible by 12)
popSize = 50;                % The size of the population (must be an even number)
maxGens = 1500;              % The maximum number of generations allowed in a run
probCrossover = .8;          % The probability of crossing over
probMutation = 0.003;        % The mutation probability (per bit)

target = 42;                 % Solution to the problem the chromosomes will solve

index = zeros(popSize,1);
chromosome = zeros(popSize,len);
phenotype = zeros(popSize,1);
fitness = zeros(popSize,1);
pFitness = zeros(popSize,2);

% Step 1: Initialize Generation 0
for j = 1:maxGens
    for i = 1:popSize
        index(i) = i;

        % Generate chromosomes for each organism
        chromosome(i,:) = round(rand(1,len));

        % Generate phenotypes from the chromosomes
        phenotype(i) = ChromoBinConverter(chromosome(i,:));

        % Calculate fitness score for each organism
        fitness(i) = 1/(target - phenotype(i)+.0001);
        % Convert fitness scores to positive values
        pFitness(i,1) = abs(fitness(i));
        if fitness(i) < 0
            pFitness(i,2) = 1;
        else
            pFitness(i,2) = 0;
        end
    end

    prob = pFitness(:,1)/sum(pFitness(:,1));

    % Step 2: Start Mating
    % Select two random mates
    for i = 1:popSize
        mates = randsample(index,2,'true',prob);
        crossPos = randi([1,len]);
        r = randi([1,100]);
        if r == 1:100*probCrossover
            chromosome(i,:) = horzcat(chromosome(mates(1),1:crossPos), chromosome(mates(2),crossPos+1:len));
        else
            chromosome(i,:) = chromosome(mates(1),:);
        end
    end

    % Step 3: Mutations
    for i = 1:popSize
        mutate = randsample([0,1],1,'true',[1-probMutation,probMutation]);
        if mutate == 1
            mutPos = randi([1,len]);
            if chromosome(i,mutPos) == 0
                chromosome(i,mutPos) = 1;
            else
                chromosome(i,mutPos) = 0;
            end
        end
    end
    
    % Generate scatterplot of the phenotype
    figure(1);
    hold off;
    scatter(index,phenotype,'fill');
    title(j);
    axis([0 len target-50 target+50]);
end