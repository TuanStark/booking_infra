#!/bin/bash

# Script để reset Portainer về trạng thái ban đầu

echo "🛑 Dừng Portainer..."
docker-compose down

echo "🗑️  Xóa volume cũ..."
docker volume rm portainer_portainer_data 2>/dev/null || echo "Volume không tồn tại hoặc đã bị xóa"

echo "🚀 Khởi động lại Portainer..."
docker-compose up -d

echo "✅ Hoàn tất! Đợi vài giây rồi truy cập http://localhost:9000"
echo "📝 Username: admin"
echo "🔑 Password: $(cat admin-password.txt)"

