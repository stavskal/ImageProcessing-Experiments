
im=imread('Eikona2.jpg');
[rows,columns,a]=size(im);
r=im(:,:,1);
g=im(:,:,2);
b=im(:,:,3);
signalEnergy=mean(r(:).^2)+mean(g(:).^2)+mean(b(:).^2)
quantized=zeros(rows,columns,a);
noiseEnergy=zeros(1,2);

a=1;
%quantizing for 4 and 6 levels
for n=[4,6]
    
    % every r/g/b color is quantized seperately
    for i=1:3
       temp_image=im(:,:,i);
       [rows,columns]=size(temp_image);
       
       min_value=min(temp_image(:));
       max_value=max(temp_image(:));
       
       %length of each quantize region
       region_length=(max_value-min_value)/n;
       
       %intervals of regions
       intervals(1)=min_value;
       for j=2:n+1
           intervals(j)=min_value+(j-1)*region_length;
       end
       
       %centroid of quantization
       for j=2:n+1
        centers(j-1)=intervals(j)-region_length/2;
       end
        
       %quantization
       for j=1:rows
           for k=1:columns
               for l=1:length(intervals)-1
                  
                   if (temp_image(j,k)>=intervals(l) && temp_image(j,k)<=intervals(l+1))
                      quantized(j,k,i)=centers(l);
                  end
                   
                   
               end
               
           end
       end
    temp_quant=quantized(:,:,i);
    
    %computing error between original and quantized
    noiseEnergy(a)=noiseEnergy(a)+mean((uint8(temp_quant(:))-temp_image(:)).^2);
    end
    a=a+1;
    figure;
    imshow(uint8(quantized))
end


