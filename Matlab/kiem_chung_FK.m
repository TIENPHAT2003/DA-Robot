H   = 80;  
D1  = 176; 
L1  = 91;
L2  = 122;
L3  = 78;
L4  = 79;

% Góc nhập vào cho mỗi khớp (thay giá trị phù hợp)
theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 0;

% Tính toán vị trí các khớp
positions = compute_fk(theta1, theta2, theta3, theta4, H, D1, L1, L2, L3, L4);

% Vẽ
figure;
hold on;
colors = {'red', 'green', 'blue', 'purple'};  % Mỗi liên kết có màu riêng

% Vẽ từng liên kết với màu khác nhau
for i = 1:size(positions, 1) - 1
    x_values = [positions(i, 1), positions(i + 1, 1)];
    y_values = [positions(i, 2), positions(i + 1, 2)];
    z_values = [positions(i, 3), positions(i + 1, 3)];
    plot3(x_values, y_values, z_values, 'Color', colors{i}, 'LineWidth', 2);
end

% Hiển thị tọa độ của điểm cuối
end_effector = positions(end, :);
text(end_effector(1), end_effector(2), end_effector(3), ...
    sprintf('(%0.2f, %0.2f, %0.2f)', end_effector(1), end_effector(2), end_effector(3)), ...
    'Color', 'black', 'FontSize', 12, 'FontWeight', 'bold');

% Thiết lập nhãn và tiêu đề
xlabel('Px');
ylabel('Py');
zlabel('Pz');
title('3D Forward Kinematics with Different Colors for Each Link and End Effector Position');
grid on;
hold off;

% Định nghĩa hàm compute_fk ở cuối file
function positions = compute_fk(theta1, theta2, theta3, theta4, H, D1, L1, L2, L3, L4)
    theta1_rad = deg2rad(theta1);
    theta2_rad = deg2rad(theta2);
    theta3_rad = deg2rad(theta3);
    theta4_rad = deg2rad(theta4);
    
    % Tọa độ của từng khớp
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
