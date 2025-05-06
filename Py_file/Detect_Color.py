import cv2
import numpy as np

# Mở camera
cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("Không mở được camera")
    exit()

# Tỷ lệ pixel sang mm (12 pixel = 10mm)
pixel_to_mm = 10 / 12
origin_x, origin_y = 248, 52  # Tọa độ gốc

# Vùng cần crop
crop_x1, crop_y1 = 99, 93
crop_x2, crop_y2 = 609, 284

while True:
    ret, frame = cap.read()
    if not ret:
        print("Không nhận được khung hình từ camera")
        break

    # Crop khung hình
    cropped_frame = frame[crop_y1:crop_y2, crop_x1:crop_x2]

    # Chuyển sang không gian HSV
    hsv = cv2.cvtColor(cropped_frame, cv2.COLOR_BGR2HSV)

    # Mask cho Blue
    mask_blue = cv2.inRange(hsv, np.array([100, 100, 50]), np.array([130, 255, 255]))

    # Mask cho Red (chia làm 2 dải Hue)
    mask_red1 = cv2.inRange(hsv, np.array([0, 100, 50]), np.array([10, 255, 255]))
    mask_red2 = cv2.inRange(hsv, np.array([160, 100, 50]), np.array([180, 255, 255]))
    mask_red = cv2.bitwise_or(mask_red1, mask_red2)

    # Mask cho Green
    mask_green = cv2.inRange(hsv, np.array([40, 100, 50]), np.array([85, 255, 255]))

    # Danh sách mask theo màu
    masks = {
        'Blue': mask_blue,
        'Red': mask_red,
        'Green': mask_green
    }

    mm_coordinates = []

    # Duyệt từng vùng màu
    for color_name, mask in masks.items():
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        for cnt in contours:
            area = cv2.contourArea(cnt)
            if area > 500:  # Bỏ nhiễu nhỏ
                x, y, w, h = cv2.boundingRect(cnt)

                # Tính tọa độ tâm
                center_x = x + w // 2
                center_y = y + h // 2

                # Tính offset từ gốc và chuyển sang mm
                offset_x = center_x - origin_x
                offset_y = center_y - origin_y
                mm_x = offset_x * pixel_to_mm
                mm_y = offset_y * pixel_to_mm

                mm_coordinates.append((round(mm_x, 3), round(mm_y, 3)))

                # Vẽ và hiển thị thông tin
                cv2.rectangle(cropped_frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
                cv2.circle(cropped_frame, (center_x, center_y), 5, (0, 0, 255), -1)
                cv2.putText(cropped_frame, f"{color_name}, {mm_x:.1f}, {mm_y:.1f}",
                            (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 2)

    # Hiển thị kết quả
    cv2.imshow('Color Detection with Coordinates', cropped_frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Giải phóng
cap.release()
cv2.destroyAllWindows()
