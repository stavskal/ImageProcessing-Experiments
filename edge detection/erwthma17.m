clc
clear
I=rgb2gray(imread('Eikona6.jpg'));
%edge detection masks
PGC=[1, 2, 1; 0,0,0; -1,-2,-1];
PGR=[-1,0,-1;-2,0,2;-1,0,1];
%convolution with image
GR=conv2(double(I),PGR);

GC=conv2(double(I),PGC);
figure;
levelc = graythresh(GC)*255;



%composition of both results
G=round(sqrt(double(GR).^2+double(GC).^2));
[rows,columns]=size(GR);

%threshold
level = graythresh(G)*255;

for i=1:rows
    for j=1:columns
        if G(i,j)>level
            G1(i,j)=255;
        else
            G1(i,j)=0;
        end
    end
end
imshow(uint8(G1));
%      
T=150
for i=1:rows
    for j=1:columns
        if G(i,j)>T
            G2(i,j)=255;
        else
            G2(i,j)=0;
        end
    end
end
figure;
imshow(uint8(G2));

%         
