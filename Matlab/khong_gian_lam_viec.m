function plotWorkspace()
    % Các thông số của robot
    H = 62;
    D1 = 176;
    L1 = 91;
    L2 = 122;
    L3 = 77;
    L4 = 78;

    % Bước cho mỗi vòng lặp
    step = 12;

    % Tạo một màu gradient từ đỏ đến xanh lam
    colorMap = jet(256);

    % Khởi tạo hình ảnh 3D
    figure;
    
    % Vẽ không gian làm việc của robot
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

    % Vẽ hai điểm có tọa độ đã cho
    %plot3(0, -368, 238, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Điểm (0, -368, 238)
    %plot3(0, 222.692, 453.62, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b'); % Điểm (0, 222.692, 453.62)

    % Đặt tên cho các điểm với chữ màu đen
    %text(0, -368, 238, '  Point A', 'FontSize', 12, 'Color', 'k', 'HorizontalAlignment', 'left');
    %text(0, 222.692, 453.62, '  Point B', 'FontSize', 12, 'Color', 'k', 'HorizontalAlignment', 'left');

    % Thiết lập màu và thanh màu cho không gian làm việc
    colormap(colorMap);
    colorbar;

    title('Không gian làm việc của Robot');
    grid on;
end
