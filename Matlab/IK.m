function [t1, t2_1, t2_2, t3_1, t3_2, t4_1, t4_2] = IK(d1, L1, L2, L3, L4, x, y, z, t)

    k = sqrt(x*x + y*y);
    %if(x >0)
    t1 = atan2d(y/k, x/k)

    E = x*cosd(t1)+ y*sind(t1) - L1 - L4*cosd(t);
    F = z-d1-L4*sind(t);

    a = -2*L2*F;
    b = -2*L2*E;
    d = L3*L3 - E*E - F*F - L2*L2;
    e = sqrt(a*a + b*b);
    alpha = atan2d((-2*L2*F)/e, (-2*L2*E)/e);

    t2_1 = atan2d(sqrt(1-d*d/(e*e)), d/e) + alpha
    t2_2 = atan2d(-sqrt(1-d*d/(e*e)), d/e) + alpha

    C23_1 = (x*cosd(t1)+y*sind(t1)-L1-L2*cosd(t2_1)-L4*cosd(t))/L3;
    S23_1 = (z-d1-L2*sind(t2_1)-L4*sind(t))/L3;
    
    t3_1 = atan2d(S23_1, C23_1)-t2_1

    C23_2 = (x*cosd(t1)+y*sind(t1)-L1-L2*cosd(t2_2)-L4*cosd(t))/L3;
    S23_2 = (z-d1-L2*sind(t2_1)-L4*sind(t))/L3;

    t3_2 = atan2d(S23_2, C23_2)-t2_2

    t4_1 = t - t2_1 - t3_1
    t4_2 = t - t2_2 - t3_2
    
