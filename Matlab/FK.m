function [x, y, z, t] = FK(d1, h, L1, L2, L3, L4, t1, t2, t3, t4)

    x = cosd(t1)*(L1 + L2*cosd(t2) + L3*cosd(t2+t3) + L4*cosd(t2+t3+t4));
    y = sind(t1)*(L1 + L2*cosd(t2) + L3*cosd(t2+t3) + L4*cosd(t2+t3+t4));
    z = d1 + h + L2*sind(t2) + L3*sind(t2+t3) + L4*sind(t2+t3+t4);
    t = t2 + t3 + t4;   