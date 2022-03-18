function FileCall (filename,pathname,delta,pixel)

image_name = imread(strcat(pathname,filename));
rgb=double(image_name);

r=rgb(:,:,1);
g=rgb(:,:,2);
b=rgb(:,:,3);

r=hrt_mat(r,delta,pixel);
g=hrt_mat(g,delta,pixel);
b=hrt_mat(b,delta,pixel);


rgb(:,:,1)=r;
rgb(:,:,2)=g;
rgb(:,:,3)=b;

im_file=imfinfo(strcat(pathname,filename));
input_file_sz_o=im_file.FileSize;
clc;
fprintf('\nOriginal File Size : %f bytes\n',input_file_sz_o);
imwrite(rgb/255,'compressed_img.jpg')
im_name = 'compressed_img.jpg';
im_file=imfinfo(im_name);
input_file_sz=im_file.FileSize;
fprintf('\nCompressed File Size : %f bytes\n',input_file_sz);
figure;
subplot(1,2,1)
imshow(image_name),title(['Original image(',num2str(input_file_sz_o),' bytes)']);
subplot(1,2,2)
imshow('compressed_img.jpg'),title(['Compressed image(',num2str(input_file_sz),' bytes)']);





