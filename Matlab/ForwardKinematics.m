syms theta1 theta2 theta3 theta4 L1 L2 L3 L4
T01 = modifiedDH(0, 0, 0, theta1);
T02 = modifiedDH(pi/2, L1, 0, theta2);
T03 = modifiedDH(0, L2, 0, theta3);
T04 = modifiedDH(0, L3, 0, theta4);
T = T01 * T02 * T03 * T04;
