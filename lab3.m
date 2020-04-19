close all
im1 = imread("imgs/ee01.jpg");
im2 = imread("imgs/ee02.jpg");
im3 = imread("imgs/ee03.jpg");

%falta refer 23 ginput

figure(1),imshow(im1);
x1=[519;607;1075;1138];
y1=[487;391;572;628]
axis on
hold on;
% Plot cross at row 100, column 50
plot(x1,y1, 'r+', 'MarkerSize', 30, 'LineWidth', 2);


figure(2),imshow(im2);
x2=[50;148;619;678];
y2=[488;387;569;624];
axis on
hold on;
% Plot cross
plot(x2,y2, 'r+', 'MarkerSize', 30, 'LineWidth', 2);

figure(22),imshow(im2);
x22=[929;680;1041;1094];
y22=[294;627;624;414];
axis on
hold on;
% Plot cross
plot(x22,y22, 'r+', 'MarkerSize', 30, 'LineWidth', 2);

figure(33),imshow(im3);
x3=[431;173;538;589];
y3=[294;632;621;417];
axis on
hold on;
% Plot cross
plot(x3,y3, 'r+', 'MarkerSize', 30, 'LineWidth', 2);

%DLT

M=[];
for i=1:4
M = [ M ;
x1(i) y1(i) 1 0 0 0 -x2(i)*x1(i) -x2(i)*y1(i) -x2(i);
0 0 0 x1(i) y1(i) 1 -y2(i)*x1(i) -y2(i)*y1(i) -y2(i)];
end

M2=[];
for i=1:4
M2 = [ M2 ;
x22(i) y22(i) 1 0 0 0 -x3(i)*x22(i) -x3(i)*y22(i) -x3(i);
0 0 0 x22(i) y22(i) 1 -y3(i)*x22(i) -y3(i)*y22(i) -y3(i)];
end

[u,s,v] = svd( M );
H = reshape( v(:,end), 3, 3 )';
H = H / H(3,3);
H12 = H;
H21 = inv(H12);

[u2,s2,v2] = svd( M2 );
H2 = reshape( v2(:,end), 3, 3 )';
H2 = H2 / H2(3,3);
H23 = H2;
H32 = inv(H23);


%Matrius H12,H21,H23,H32 done

%get points
p1= [1 1 1; size(im1,2) 1 1; 1 size(im1,1) 1; size(im1,2) size(im1,1) 1]';
p2 = H12 * p1;
pr = p2./p2(3,:)


b = 1;
while(b ~= 3)
figure(22)
[x y b] = ginput(1);
p = H2*[x y 1]';
p = p/p(3);
figure(33)
hold on
plot(p(1),p(2),'rx','MarkerSize',20,'LineWidth',3);
hold off
end
