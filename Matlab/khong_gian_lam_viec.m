function plotWorkspace()
    % Các thông số của robot
    H = 80;  
    D1 = 176 ;
    L1 = 91;
    L2 = 122;
    L3 = 78;
    L4 = 79;
    
    step = 12; % Bước cho mỗi vòng lặp
    % Tạo một màu gradient từ đỏ đến xanh lam
    colorMap = jet(256);
    figure;
    for t1 = -90:step:90
        for t2 = -90:step:90
            for t3 = -90:step:90
                for t4 = -90:step:90
                    [x, y, z, ~] = FK(D1, H, L1, L2, L3, L4, t1, t2, t3, t4);
                    % Chuyển đổi giá trị của t1 từ khoảng [-90, 90] thành chỉ số trong bảng màu
                    colorIndex = round((t1 + 90) / 180 * 255) + 1;
                    color = colorMap(colorIndex, :);
                    plot3(x, y, z, '.', 'Color', color);
                    xlabel('X');
                    ylabel('Y');
                    zlabel('Z');
                    hold on;
                end
            end
        end
    end
    colormap(colorMap);
    colorbar;
end