syms t0 tf v0 vf q0 qf
Y = [q0; v0; qf; vf ];
A = [1  t0   t0*t0   t0*t0*t0;
     0  1    2*t0    3*t0*t0;
     1  tf   tf*tf   tf*tf*tf;
     0  1    2*tf    3*tf*tf];
X = simplify(A^(-1)*Y);
