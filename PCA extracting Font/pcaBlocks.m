A=load('boostrap.mat');
video_sequence=A.video;
reshaped=zeros(1500,19200);

for k=1:1500
  temp_images=video_sequence(:,:,k);%temporary saving frames
  C=transpose(temp_images); 
  %converting to column vectors
  D=C(:);
  reshaped(k,:)=transpose(D);%inserted in matrix rows
          
end
%reshaped is a matrix whose rows are
%each frame from the initial video
meanvalues2=zeros(19200,1);

%substracting mean value from each row
for k=1:19200
    meanvalues2(k)=mean(reshaped(:,k));
    reshaped(:,k)=reshaped(:,k)-meanvalues2(k);
end

%Principal Component Analysis on 100 frame blocks
for j=100:100:800 
    XXT=reshaped((j-99):j,:)*(reshaped((j-99):j,:)');
    [U,S,~]=svd(XXT,'econ');
    %keeping only first 3 principal components
    for i=3:100
       U(i,:)=0; 

    end
    V1=reshaped((j-99):j,:)'*U*inv(S);
    for i=10:100
        S(i,i)=0;

    end
    X((j-99):j,:)=U*S*V1';

end

%adding mean values to video
for k=1:19200
    X(:,k)=X(:,k)+meanvalues2(k);
end

for i=1:800
   reformed(:,:,i)=vec2mat(X(i,:),160); %reconstructing video
end
implay(reformed);