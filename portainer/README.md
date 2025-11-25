# Portainer - Docker Management UI

Portainer là công cụ quản lý Docker containers qua giao diện web.

## Cài đặt

1. **Cấu hình IP trong file `.env`** (nếu cần):
   ```env
   PORTAINER_IP=172.20.0.100
   ```

2. **Chạy Portainer**:
   ```bash
   cd booking_infra/portainer
   docker-compose up -d
   ```

   Hoặc từ thư mục gốc:
   ```bash
   docker-compose -f booking_infra/portainer/docker-compose.yml up -d
   ```

3. **Truy cập Portainer**:
   - HTTP: http://localhost:9000
   - HTTPS: https://localhost:9443

## Cấu hình mật khẩu

1. **Tạo file mật khẩu** (nếu chưa có):
   ```bash
   cp admin-password.txt.example admin-password.txt
   ```

2. **Chỉnh sửa mật khẩu** trong file `admin-password.txt`:
   ```bash
   nano admin-password.txt
   # Nhập mật khẩu bạn muốn (tối thiểu 12 ký tự)
   ```

3. **Lưu ý**: File `admin-password.txt` đã được thêm vào `.gitignore` để bảo mật.

## Lần đầu sử dụng

1. **Nếu Portainer đã chạy trước đó**, cần xóa data cũ:
   ```bash
   docker-compose down -v
   docker volume rm portainer_portainer_data 2>/dev/null || true
   ```

2. **Khởi động lại Portainer**:
   ```bash
   docker-compose up -d
   ```

3. **Kiểm tra logs** (để xem có lỗi không):
   ```bash
   docker logs booking_portainer
   ```

4. Mở trình duyệt và truy cập http://localhost:9000

5. Đăng nhập với:
   - Username: `admin`
   - Password: `admin123456` (hoặc mật khẩu trong file `admin-password.txt`)

6. Chọn "Docker" environment

7. Bắt đầu quản lý containers!

## Troubleshooting

### Lỗi "Login failed"

1. **Kiểm tra file mật khẩu**:
   ```bash
   cat admin-password.txt
   # Đảm bảo không có ký tự đặc biệt hoặc newline thừa
   ```

2. **Xóa data cũ và tạo lại**:
   ```bash
   docker-compose down -v
   docker volume rm portainer_portainer_data 2>/dev/null || true
   docker-compose up -d
   ```

3. **Kiểm tra file có được mount đúng không**:
   ```bash
   docker exec booking_portainer cat /tmp/admin-password.txt
   ```

4. **Nếu vẫn lỗi**, có thể Portainer đã tạo admin trước đó. Thử:
   - Xóa volume: `docker volume rm portainer_portainer_data`
   - Hoặc reset password qua Portainer UI (nếu đã login được trước đó)

## Tính năng

- ✅ Quản lý containers, images, volumes, networks
- ✅ Xem logs real-time
- ✅ Quản lý Docker Compose stacks
- ✅ Monitor resource usage
- ✅ Web-based terminal
- ✅ User management

## Reset Portainer (nếu gặp lỗi login)

Nếu bạn gặp lỗi login, chạy script reset:

```bash
./reset.sh
```

Hoặc thủ công:

```bash
# Dừng và xóa volume
docker-compose down -v
docker volume rm portainer_portainer_data 2>/dev/null || true

# Khởi động lại
docker-compose up -d
```

## Dừng Portainer

```bash
docker-compose -f booking_infra/portainer/docker-compose.yml down
```

## Xóa dữ liệu Portainer

```bash
docker-compose -f booking_infra/portainer/docker-compose.yml down -v
```

## Lưu ý

- Portainer cần quyền truy cập Docker socket để quản lý containers
- Data được lưu trong volume `portainer_data`
- Portainer chạy trên cùng network `my_custom_network` với các service khác

