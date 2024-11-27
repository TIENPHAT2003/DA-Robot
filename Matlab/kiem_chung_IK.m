% Các thông số của robot
H   =   80;  
D1  =   176; 
L1  =   91;
L2  =   122;
L3  =   78;
L4  =   79;

% Giá trị đầu vào cho tọa độ của điểm cuối
Px_IK = 160;
Py_IK = 0;
Pz_IK = 20;
Theta_IK = -90;

% Tính các góc động học nghịch
[Theta1, Theta2, Theta3, Theta4] = inverse_kinematics(Px_IK, Py_IK, Pz_IK, Theta_IK);
fprintf('Calculated IK Angles:\nTheta1: %.2f, Theta2: %.2f, Theta3: %.2f, Theta4: %.2f\n', Theta1, Theta2, Theta3, Theta4);

% Tính vị trí các khớp từ các góc
positions = compute_fk(Theta1, Theta2, Theta3, Theta4, L1, L2, L3, L4, H, D1);

% Vẽ đồ thị
figure;
hold on;
colors = ['r', 'g', 'b', 'm'];  % Màu sắc cho mỗi liên kết

% Vẽ từng liên kết với màu khác nhau
for i = 1:size(positions, 1) - 1
    plot3([positions(i, 1), positions(i + 1, 1)], ...
          [positions(i, 2), positions(i + 1, 2)], ...
          [positions(i, 3), positions(i + 1, 3)], ...
          'Color', colors(i), 'LineWidth', 2);
end

% Hiển thị tọa độ của điểm cuối
end_effector = positions(end, :);
text(end_effector(1), end_effector(2), end_effector(3), ...
    sprintf('(%0.2f, %0.2f, %0.2f)', end_effector(1), end_effector(2), end_effector(3)), ...
    'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');

% Thiết lập nhãn và tiêu đề
xlabel('Px');
ylabel('Py');
zlabel('Pz');
title('3D Inverse Kinematics Visualization with Different Colors for Each Link');
grid on;
view(3);
hold off;

% === Định nghĩa hàm động học nghịch ===
function [Theta1, Theta2, Theta3, Theta4] = inverse_kinematics(Px_IK, Py_IK, Pz_IK, Theta_IK)
    H = 80;
    D1 = 176;
    L1 = 91;
    L2 = 122;
    L3 = 78;
    L4 = 79;
    
    t_rad = deg2rad(Theta_IK);
    k = sqrt(Px_IK^2 + Py_IK^2);
    
    theta1_IK_rad = atan2(Py_IK / k, Px_IK / k);
    E = Px_IK * cos(theta1_IK_rad) + Py_IK * sin(theta1_IK_rad) - L1 - L4 * cos(t_rad);
    F = Pz_IK - D1 - H - L4 * sin(t_rad);
    
    a = -2 * L2 * F;
    b = -2 * L2 * E;
    d = L3^2 - E^2 - F^2 - L2^2;
    f = sqrt(a^2 + b^2);
    anpha = atan2(a / f, b / f);
    
    var_temp = (d / f) ^ 2;
    var_temp = min(max(var_temp, -1), 1);  % Giới hạn giá trị để tránh lỗi tính toán
    
    theta2_IK_rad = atan2(-sqrt(1 - var_temp), d / f) + anpha;
    c23 = (Px_IK * cos(theta1_IK_rad) + Py_IK * sin(theta1_IK_rad) - L1 - L2 * cos(theta2_IK_rad) - L4 * cos(t_rad)) / L3;
    s23 = (Pz_IK - D1 - H - L2 * sin(theta2_IK_rad) - L4 * sin(t_rad)) / L3;
    theta3_IK_rad = atan2(s23, c23) - theta2_IK_rad;
    theta4_IK_rad = t_rad - theta2_IK_rad - theta3_IK_rad;
    
    Theta1 = rad2deg(theta1_IK_rad);
    if(Theta1 < -180)
        Theta1 = Theta1 + 360;
    end
    if(Theta1 >= 180)
        Theta1 = Theta1 - 360;
    end
    Theta2 = rad2deg(theta2_IK_rad);
    if(Theta2 < -180)
        Theta2 = Theta2 + 360;
    end
    if(Theta2 >= 180)
        Theta2 = Theta2 - 360;
    end
    Theta3 = rad2deg(theta3_IK_rad);
    if(Theta3 < -180)
        Theta3 = Theta3 + 360;
    end
    if(Theta3 >= 180)
        Theta3 = Theta3 - 360;
    end
    Theta4 = rad2deg(theta4_IK_rad);
end

% === Định nghĩa hàm động học thuận ===
function positions = compute_fk(Theta1, Theta2, Theta3, Theta4, L1, L2, L3, L4, H, D1)
    theta1_rad = deg2rad(Theta1);
    theta2_rad = deg2rad(Theta2);
    theta3_rad = deg2rad(Theta3);
    theta4_rad = deg2rad(Theta4);
    
    x0 = 0; y0 = 0; z0 = H;
    x1 = cos(theta1_rad) * L1;
    y1 = sin(theta1_rad) * L1;
    z1 = H + D1;

    x2 = x1 + cos(theta1_rad) * L2 * cos(theta2_rad);
    y2 = y1 + sin(theta1_rad) * L2 * cos(theta2_rad);
    z2 = z1 + L2 * sin(theta2_rad);

    x3 = x2 + cos(theta1_rad) * L3 * cos(theta2_rad + theta3_rad);
    y3 = y2 + sin(theta1_rad) * L3 * cos(theta2_rad + theta3_rad);
    z3 = z2 + L3 * sin(theta2_rad + theta3_rad);

    x4 = x3 + cos(theta1_rad) * L4 * cos(theta2_rad + theta3_rad + theta4_rad);
    y4 = y3 + sin(theta1_rad) * L4 * cos(theta2_rad + theta3_rad + theta4_rad);
    z4 = z3 + L4 * sin(theta2_rad + theta3_rad + theta4_rad);

    positions = [x0, y0, z0; x1, y1, z1; x2, y2, z2; x3, y3, z3; x4, y4, z4];
end
