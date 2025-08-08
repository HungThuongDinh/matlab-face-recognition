clc;
load scrap; % Loading database file
[filename, pathname]=uigetfile('*.*', 'Select the Input Image');
filewithpath=strcat(pathname, filename);
img=imread(filewithpath);
imgo=img;
    % Processing query image
img=rgb2gray(img);
img=imresize(img,[M,N]);
img=double(reshape(img,[1,M*N]));
imgpca=(img-m)*Ppca; % Projecting image to PCA space
distarray=zeros(n,1);
for i=1:n
    distarray(i)=sum(abs(T(i,:)-imgpca)); % Compute difference
end
[result,indx]=min(distarray); % Getting best match
resultimg=imread(sprintf('%d.jpg',indx));
    % Displaying results
subplot(121)
imshow(imgo);
title('Query Face');
subplot(122)
imshow(resultimg);
title('Recognized Face');