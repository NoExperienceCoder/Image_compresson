function HaarTrnsfrm =hrt_mat(in,delta,pixel)
count = log2(pixel);
temp=1;
A = zeros(pixel);
Size= pixel/2;
for i=1:Size
    for j=1:Size
        if i==j
        A(2*i-1,j)= 0.5;
        A(2*i,j)= 0.5;
        A(2*i-1,j+Size)= 0.5;
        A(2*i,j+Size)= -0.5;
        end
    end    
end
temp=temp+1;
Size= Size*2;
while temp<=count
 A(:,:,temp) = zeros(pixel);
  for i=1:Size
    for j=1:Size
        if i<=Size/2^temp 
            if i==j
        A(2*i-1,j,temp)= 0.5;
        A(2*i,j,temp)= 0.5;
        A(2*i-1,j+Size/2^temp,temp)= 0.5;
        A(2*i,j+Size/2^temp,temp)= -0.5;
            end   
        elseif i>Size/2^(temp-1)
                A(i,i,temp)= 1;
        end
    end    
  end
  temp=temp+1;
end
for m=1:count
    A(:,:,m) = normc(A(:,:,m));
end    
H= eye(pixel);
for k=1:count
    H = H*A(:,:,k);
end
[len,bred] = size(in);
out = zeros(size(in));
jump = (2^count)-1;
   for i=0:(jump+1):(len-jump-1)
      for j=0:(jump+1):(bred-jump-1)
        p=i+1;
        q=j+1;
        out(p:p+jump,q:q+jump)=(H')*in(p:p+jump,q:q+jump)*H;
      end
   end 
HaarTrnsfrm = out;
Max_ele  = max(max(out));
out = out/ Max_ele;
out(abs(out)<delta)=0;
out = out *Max_ele;

   for i=0:(jump+1):(len-jump-1)
      for j=0:(jump+1):(bred-jump-1)
        p=i+1;
        q=j+1;
        HaarTrnsfrm(p:p+jump,q:q+jump)=H*out(p:p+jump,q:q+jump)*H';
      end
   end
