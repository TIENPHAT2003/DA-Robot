import cv2
import math

ref_points = []
pixel_distance = 0

def click_event(event, x, y, flags, param):
    global ref_points
    if event == cv2.EVENT_LBUTTONDOWN:
        ref_points.append((x, y))
        print(f"Điểm {len(ref_points)}: {x}, {y}")
        if len(ref_points) == 2:
            # Tính khoảng cách pixel
            x1, y1 = ref_points[0]
            x2, y2 = ref_points[1]
            distance = math.hypot(x2 - x1, y2 - y1)
            print(f"\nKhoảng cách pixel: {distance:.2f}")
            real_length_mm = float(input("Nhập chiều dài thực tế giữa 2 điểm (mm): "))
            pixel_to_mm = real_length_mm / distance
            print(f"Tỷ lệ chuyển đổi: {pixel_to_mm:.4f} mm/pixel")

cap = cv2.VideoCapture(0)
cv2.namedWindow("Camera")
cv2.setMouseCallback("Camera", click_event)

print("Click chuột trái vào 2 điểm trên khung hình để đo pixel...\n")

while True:
    ret, frame = cap.read()
    if not ret:
        print("Không mở được camera.")
        break

    # Vẽ các điểm được click
    for pt in ref_points:
        cv2.circle(frame, pt, 5, (0, 255, 0), -1)
    if len(ref_points) == 2:
        cv2.line(frame, ref_points[0], ref_points[1], (0, 0, 255), 2)

    cv2.imshow("Camera", frame)

    key = cv2.waitKey(1) & 0xFF
    if key == ord('r'):
        ref_points.clear()  # Reset điểm nếu cần
        print("\nReset điểm đo")
    elif key == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
