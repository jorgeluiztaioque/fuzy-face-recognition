%limpando variaveis e terminal.
%cleaning the variables and terminal
clear all;
close all;
clc;
 
%inicia contador de tempo
%start counter of time
tic;
 
%procura imagem inicial
%Search initial image
imagefiles = dir('*.pgm');      
nfiles = length(imagefiles);  
	forResult = zeros(1,nfiles);
	y = randi([1, nfiles]);
 
	for ii=1:nfiles
		if (ii == y)
		currentfilename = imagefiles(ii).name;
		inputImage = imread(currentfilename);
		images{ii} = inputImage;
		end
	end
 
 
		inputImage=inputImage;
		diferente = currentfilename;
 
%seta tamanho da janela de verificação
%set window size
windowSize=3;
 
inputImage=inputImage;
 
%executa função fuzy
%execuit function fuzy
res = fuzy(inputImage, windowSize, 0.950);
 
% 0.950 melhor valor que encontrei para fuzy
 
 
%pega parametros da imagen para criar histograma
%get parameters of image to create histogram
larg = size(res,2) ;
alt  = size(res,1) ;
minimo = min(min(res)) ;
maximo = max(max(res)) ;
img_contraste = 255 * ( double(res - minimo) / double(maximo - minimo) );
 
histograma = zeros(1,256) ;
 
%criando histograma
%creating histegram
for i = 1 : alt
    for j = 1 : larg
        histograma(floor(img_contraste(i,j)+1)) = histograma(floor(img_contraste(i,j)+1)) + 1 ;
    end
end
 
	%calculando histograma
	%calculating histogram
	resultado1 = sum(histograma);
 
	%mostra resultados na janela figura
	%show results in window figure
	figure,
	subplot(2,3,1); plot(1:256,histograma,'-b');
	title('Histograma Original');
	subplot(2,3,3); imshow(inputImage);
	title('Imagem Original');
	drawnow 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%procura imagen canditada 
	%Search image candidate
	imagefiles = dir('*.pgm');      
	nfiles = length(imagefiles); 
 
	%Vector of results
	%Vetor de resultados
	forResult = zeros(1,nfiles);
	resultchi = 999999999999999;
 
	for ii=1:nfiles
 
	currentfilename = imagefiles(ii).name;
 
	z = strcmp( currentfilename, diferente );
	if (z==0)
 
	inputImage2 = imread(currentfilename);
	images{ii} = inputImage2;
 
 
windowSize=3;
 
inputImage2=inputImage2;
 
 
%executando função fuzy
%running fuzy function
res2 = fuzy(inputImage2, windowSize, 0.950);
 
%pega parametros do fuzy para criar histograma
%get parameters of fuzy to create histogram
larg = size(res2,2) ;
alt  = size(res2,1) ;
minimo = min(min(res2)) ;
maximo = max(max(res2)) ;
img_contraste2 = 255 * ( double(res2 - minimo) / double(maximo - minimo) );
 
histograma2 = zeros(1,256) ;
 
%criando histograma
%creating histegram
for i = 1 : alt
    for j = 1 : larg
        histograma2(floor(img_contraste2(i,j)+1)) = histograma2(floor(img_contraste2(i,j)+1)) + 1 ;
    end
end
 
	%calculando chi-quadrado
	%calculating chi-square
	reschi = sum((histograma - histograma2).^2);
 
	%vetor para resultados do chi
	% Vector for results of chi
	forResult(ii) = reschi;
 
	%procura menor resultado do chi
	%search menor result of chi
	if ( reschi < resultchi )
	resultchi = reschi;
	reshistograma = histograma2;
	resresultado = res2;
	resimage = inputImage2;
	end 
 
 
	subplot(2,3,4); plot(1:256,histograma2,'-b');
	title('Histograma');
	subplot(2,3,6); imshow(inputImage2);
	title('Imagem Candidata');
	drawnow 
	ii
 
	end
end
 
	%mostra resultado
	%show result
	subplot(2,3,4); plot(1:256,reshistograma,'-b');
	title('RESULTADO');
	subplot(2,3,6); imshow(resimage);
	title('RESULTADO');
	drawnow 
 
 
%mostra tempo de procesamento
%show processing time
time=toc;
time
