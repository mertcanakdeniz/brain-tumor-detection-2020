clc, clear all, close all

I=imread('images/sample_input_2.jpg');
figure,
imshow(I);title('Orjinal Görüntü0');


Igray=rgb2gray(I);

level= .5 ;  %graythresh(Igray);
Ithresh=im2bw(Igray,level);
figure,imshow(Ithresh)
BWs = edge(Ithresh,'sobel');
figure,imshow(BWs),title('Binary kenar görüntü');


se90=strel('line', 3, 90);
se0= strel('line', 3, 0);

Bwadil=imdilate(BWs, [se90 se0]);
figure,imshow(Bwadil),title('genişletilmiş görüntü');

Bwfill = imfill(Bwadil,'holes');
figure,imshow(Bwfill),title('Bosluklar giderilmiş görüntü');

Bwnobord = imclearborder(Bwfill,4);
figure,imshow(Bwnobord),title('sınırları temizlenmiş görüntü');

seD =strel ('diamond',4);
Bwfinal=imerode(Bwnobord,seD);
Bwfinal2=imerode(Bwfinal,seD);
figure,imshow(Bwfinal2),title('bölünmüş görüntü');


Bedge=bwboundaries(Bwfinal2);

figure,imshow(I),title('orginal sonuc görüntü');
text(10,10,strcat('\color{red}bulunan tumor :',num2str(length(Bedge))))
hold on 
for k = 1:length(Bedge)
    boundary = Bedge{k};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', .5)
end
