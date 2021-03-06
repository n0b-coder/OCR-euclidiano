function [fl re]=lines(im_texto)

% 1. Recupera el número de filas en la imagen
nFilas=size(im_texto,1);

for s=1:nFilas %Recorrer todas las filas
    if sum(im_texto(s,:))== 0 %Si la sumatoria en esa fila de la imagen es 0
        
        %Entonces no hay texto, es espacio
        nm=im_texto(1:s-1, :); % Primera línea,
                               % desde 1 hasta donde detectó el espacio.1
        %imshow(nm);
        rm=im_texto(s:end, :);% Lo que queda de la imagen
                              % desde donde quedó arriba hasta el resto de
                              % la imagen
        %demostración de rm figure, imshow(rm);   
        
        % Esto es para recortar espacios extra en negro
        fl = clip(nm);
        re=clip(rm);
        
        %subplot(2,1,1);imshow(fl);
        %subplot(2,1,2);imshow(re);
        break
    else
        % Si solo es una línea de texto
        % devuelve la imagen que entró
        fl=im_texto;
        % Vacío
        re=[ ];
    end
end

function img_out=clip(img_in)
% Hallar índices de elementos <> 0 (o = 1)
[f,c]=find(img_in);
% imagen de salida: min(f)->coge el índice menor de las filas donde la
% imagen = 1 por ejemplo (x,y)=(1,1) y
% max(f)->coge el índice mayor de las filas donde la imagen = 1
% Cuando uno indexa img_in con esos valores básicamente solo coge esa
% región rectangular
img_out=img_in(min(f):max(f),min(c):max(c));%Corta la imagen