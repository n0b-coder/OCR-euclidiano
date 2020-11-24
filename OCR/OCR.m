%OCR empleando histograma de gradientes
addpath('C:\Users\USER\Documents\Uni\Im�genes\OCR\OCR HOG\imgs')

warning off %#ok<WNOFF>
%La imagen de entrada
imagen=imread('TEST_2.jpg');
imshow(imagen);
title('Imagen original')
imagen=im2gray(imagen);

%Binarizar
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);

%Quitar objetos con menos de 30 pixeles
imagen = bwareaopen(imagen,30);

%Storage matrix word from image
word=[ ];
re=imagen;

%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
load templates
global templates
% Compute the number of letters in template file
num_letras=size(templates,2);

disp(num_letras)

count=1;


while 1
    %Fcn 'lines' separate lines in text
    [fl re]=lines(re);
    imgn=fl;
    %Uncomment line below to see lines one by one
    %imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L Ne] = bwlabel(imgn);
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
        %imshow(img_r);pause(0.5)
        %%HOG
        img_r=matlab_HOG(img_r);
        
        %disp(size(img_r))
        
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        
        %Aqu� est� comparando
        letter=read_letter(img_r, num_letras);
        count=count+1;
        disp(count)
        %letter=read_letter(img_r,num_letras);
        % Letter concatenation
        
        %word=[word letter];
    end
    %fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
    fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    %word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
end
%fclose(fid);
%Open 'text.txt' file
% winopen('text.txt')
% fprintf('For more information, visit: <a href= "http://www.matpic.com">www.matpic.com </a> \n')
% clear all