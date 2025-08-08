        % Step 1: Processing the database
n=input('Enter No. of images for training: ');
L=input('Enter No. of Dominant Eigen values to keep: ');
M=100; N=90;
X=zeros(n, (M*N)); % Initialize data set matrix [X]
T=zeros(n,L); % Initialize Transformed data set matrix [T]
for count=1:n
	I=imread(sprintf('%d.jpg',count+15));
	I=rgb2gray(I);
	I=imresize(I,[M,N]);
	X(count,:)=reshape(I,[1,M*N]); % Reshaping images as 1D vectors
end
Xb=X;
m=mean(X); % Find Mean of all images
for i=1:n
	X(i,:)=X(i,:)-m; % Subtracting Mean from each 1D image
end
        % Step 2: Compute Covariance matrix
Q=(X'*X)/(n-1);
        % Step 3: Compute the eigenvalues and eigenvectors
[Evecm,Evalm]=eig(Q);
Eval=diag(Evalm);
        % Step 4: Select the largest L eigenvalues
[Evalsorted,Index]=sort(Eval,'descend');
Evecsorted=Evecm(:,Index);
        % Step 5: Form the transformation matrix Ppca
Ppca=Evecsorted(:,1:L);
        % Stop 6: Transform original data [X] to obtain new data [T]
for i=1:n
	T(i,:)=(Xb(i,:)-m)*Ppca;
end