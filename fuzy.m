%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LFP - Local Fuzzy Pattern
%
% Input arguments:
% img - Gray scale image.
% neighborSize - number of sample point in an square window.
% beta - pertinence function argument.
%
function result = LFP(img, neighborSize, beta)
if neighborSize < 3 || floor(neighborSize/2) == 0
error('A vizinhança deve ser um número ímpar maior ou igual a 3!');
end;
img = double(img);
% Tamanho da imagem original
[ysize xsize] = size(img);
if(xsize < neighborSize || ysize < neighborSize)
error('Imagem muito pequena. Deve ter pelo menos o tamanho da janela.');
end
% weightMatrix = [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
weightMatrix = [1 1 1; 1 1 1; 1 1 1]; %matriz de pesos 1
%weightMatrix = [1 1 1; 1 0 1; 1 1 1]; %matriz de pesos 2
border = fix(neighborSize/2);
dataMatrix = img(2*border : ysize - border, 2*border : xsize - border);
[matrixSizeY matrixSizeX] = size(dataMatrix);
pertinenceSum = zeros(matrixSizeY, matrixSizeX);
weightSum = 0;
for i = 1 : neighborSize
for j = 1 : neighborSize
weight = weightMatrix(i, j);
windowData = img(i : (i+matrixSizeY) - 1, j : (j+matrixSizeX) - 1);
expData = windowData - dataMatrix;
pert = 1./(1 + exp(-expData/beta));
pertinenceSum = pertinenceSum + (pert * weight);
weightSum = weightSum + weight;
end;
end;
result = pertinenceSum / weightSum;
