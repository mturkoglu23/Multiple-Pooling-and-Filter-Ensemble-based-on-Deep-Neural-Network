function imgg=maxpool(img111)

% I2 = im2double(img111);

 img=imresize(img111,[516 768]);
%  imshow(img)


 im{1}=img(1:172,1:256);
 im{2}=img(1:172,257:512);
 im{3}=img(1:172,513:768);
 im{4}=img(173:344,1:256);
 im{5}=img(173:344,257:512);
 im{6}=img(173:344,513:768);
 im{7}=img(345:516,1:256);
 im{8}=img(345:516,257:512);
 im{9}=img(345:516,513:768);

 for ii=1:9   
x1=imresize(im{ii}, [171 255]);
X=3;Y=3; %window sizes
fun = @(block_struct) max(block_struct.data(:));
b1 = blockproc (x1(:,:,1), [X Y], fun);
bb(:,:,1)=b1;
img1=bb;
img1 = ordfilt2(img1,9,ones(3,3));
im1{ii}=imresize(img1, [172 256]);
end
 
 img11(1:172,1:256)=im1{1};
 img11(1:172,257:512)=im1{2};
 img11(1:172,513:768)=im1{3};
 img11(173:344,1:256)=im1{4};
 img11(173:344,257:512)=im1{5};
 img11(173:344,513:768)=im1{6};
 img11(345:516,1:256)=im1{7};
 img11(345:516,257:512)=im1{8};
 img11(345:516,513:768)=im1{9};
 img11=uint8(img11);
 imgg=cat(3,img11,img11,img11);
 imgg=imresize(imgg,[224 224]);

     
