clc
close all
% Các thông số của robot
H = 80;  
D1 = 176 ;
L1 = 91;
L2 = 122;
L3 = 78;
L4 = 79;
% Định nghĩa các thông số của quỹ đạo
theta_0 = [-90, 30, 0, 0]; % Vị trí ban đầu của các joint
theta_f = [90, 60, 30, 25]; % Vị trí cuối của các joint
tf = 4; % Thời gian di chuyển từ q0 đến qf
t = 0:0.01:tf; % Thời điểm
% Tính toán các hệ số cho mỗi joint
a0 = theta_0;
a1 = zeros(1, 4);
a2 = 3 * (theta_f - theta_0) / tf^2;
a3 = -2 * (theta_f - theta_0) / tf^3;
% Tính toán quỹ đạo cho mỗi joint
qt = zeros(length(t), 4);
vt = zeros(length(t), 4);
at = zeros(length(t), 4);
for i = 1:4
    qt(:, i) = a0(i) + a1(i) * t + a2(i) * t.^2 + a3(i) * t.^3;
    vt(:, i) = a1(i) + 2 * a2(i) * t + 3 * a3(i) * t.^2;
    at(:, i) = 2 * a2(i) + 6 * a3(i) * t;
    % Động học thuận
    % Thêm mô hình động học của robot vào đây
    % torques(:, i) = compute_forward_dynamics(H, D1, L1, L2, L3, L4, qt(:, i), vt(:, i), at(:, i), t);
end
% Vẽ đồ thị
figure
for i = 1:4
    % Subplot cho vị trí
    subplot(4, 1, i)
    plot(t, qt(:, i), 'Color', rand(1,3));
    title(['Khâu ' num2str(i) ':' ' Vị trí']);
    xlabel('Thời gian (s)');
    ylabel('Vị trí (Degree)');
    grid on
end
% Tạo figure mới để vẽ các đồ thị còn lại
figure
for i = 1:4
    % Subplot cho vận tốc
    subplot(4, 1, i)
    plot(t, vt(:, i), 'Color', rand(1,3));
    title(['Khâu ' num2str(i) ':' ' Vận tốc']);
    xlabel('Thời gian (s)');
    ylabel('Vận tốc (Degree/s)');
    grid on
end

% Tạo figure mới để vẽ các đồ thị còn lại
figure
for i = 1:4
    % Subplot cho gia tốc
    subplot(4, 1, i)
    plot(t, at(:, i), 'Color', rand(1,3));
    title(['Khâu ' num2str(i) ':' ' Gia tốc']);
    xlabel('Thời gian (s)');
    ylabel('Gia tốc (Degree/s^2)');
    grid on
end