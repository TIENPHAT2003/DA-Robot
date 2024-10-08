% khong gian lam viec
d1=141.24;
L1=91.2;
L2=122;
L3=77;
L4=60;

for t1=-90:1:90
    for t2=-90:1:90
       for t3 =-90:1:90
           for t4 =-90:1:90
               [x,y,z,t] = FK(d1, L1, L2, L3, L4, t1, t2, t3, t4);
               plot3(x,y,z,'.');
               xlabel('X');
               ylabel('Y');
               zlabel('Z');
               hold on
           end
       end
    end
end

