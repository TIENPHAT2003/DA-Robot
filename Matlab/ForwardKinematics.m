syms theta1 theta2 theta3 theta4 L1 L2 L3 L4 D1 H
T01 = [cos(theta1), -sin(theta1), 0, 0;
       sin(theta1), cos(theta1), 0, 0;
       0, 0, 1, 0;
       0, 0, 0, 1];
T12 = [cos(theta2), -sin(theta2), 0, L1
       0, 0, -1, 0
       sin(theta2), cos(theta2), 0, 0
       0, 0, 0, 1];
T23 = [cos(theta3), -sin(theta3), 0, L2
       sin(theta3), cos(theta3), 0, 0
       0, 0, 1, 0
       0, 0, 0, 1];
T34 = [cos(theta4), -sin(theta4), 0, L3
       sin(theta4), cos(theta4), 0, 0
       0, 0, 1, 0
       0, 0, 0, 1];
T4EE = modifiedDH(0,L4,0,0);
TC0 = [1 0 0 0;
       0 1 0 0;
       0 0 1 D1+H;
       0 0 0 1];
T_FK = simplify(T01*T12*T23*T34*T4EE);
TC_EE = simplify(TC0*T_FK);
