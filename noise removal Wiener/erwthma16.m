clc
clear

im1=rgb2gray(imread('Eikona5.jpg'));

im=im1(1:300,1:300);
 [x,y]=size(im);


signal_energy=mean(im(:).^2);
dev=signal_energy/3;

%low SQNR gaussian noise added
noise=sqrt(dev.^2)*uint8(randn(x,y));

noise_freq=fftshift(fft2(noise));

pn1=mean(mean(noise_freq))./(x*y);

% adding noise
im_noise=im+noise;
imshow(im_noise);

freqdom=fftshift(fft2(im_noise));

%estimating spectral density of noisy image
pg = (abs(freqdom).^2)./(x*y);
   
%estimating noise energy without prior knowledge
pn=(mean(mean((freqdom(280:end,280:end)/(x*y)))));

pf=pg-pn;

%wiener filter
H=pf./(pf+pn);
  

  
 h=ifft2(H);

%2d fft with padding 
H1=fft2(h,512,512);

im_freq=fft2(double(im),512,512);

%filtering in frequency domain
last=H1.*im_freq;

last=ifft2(last);
 figure;
 imshow(last(1:300,1:300),[])