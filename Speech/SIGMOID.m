function [act] = SIGMOID(input, W, b)

batchSize = size(input,1);
act = input * W + repmat(b,batchSize,1);
act = 1./ (1+exp(-act));

end