function test()
    % Các thông số của robot
    H = 80;  
    D1 = 176;
    L1 = 91;
    L2 = 122;
    L3 = 78;
    L4 = 79;
    
    step = 12; % Bước cho mỗi vòng lặp
    colorMap = jet(256); % Tạo một màu gradient từ đỏ đến xanh lam
    figure;
    hold on; % Giữ đồ thị để có thể thêm các điểm vào

    for t1 = -90:step:90
        for t2 = -90:step:90
            for t3 = -90:step:90
                for t4 = -90:step:90
                    % Gọi hàm FK để tính vị trí của đầu cuối
                    [x, y, z, ~] = FK(D1, H, L1, L2, L3, L4, t1, t2, t3, t4);
                    
                    % Xác định màu dựa trên giá trị của t1
                    colorIndex = round((t1 + 90) / 180 * 255) + 1;
                    color = colorMap(colorIndex, :);

                    % Vẽ điểm không gian làm việc với màu tương ứng
                    plot3(x, y, z, '.', 'Color', color);
                end
            end
        end
    end
    
    % Thiết lập đồ thị
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Không gian làm việc của robot 4 bậc tự do');
    grid on;
    axis equal;
    colormap(colorMap); % Cài đặt bảng màu
    colorbar; % Hiển thị thanh màu
    hold off; % Kết thúc giữ đồ thị
end
