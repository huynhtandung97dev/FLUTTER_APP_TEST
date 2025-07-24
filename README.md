# 🛍️ Product Management App (Flutter Clean Architecture)

Ứng dụng di động Flutter giúp người dùng **quản lý sản phẩm** với đầy đủ tính năng CRUD, lưu trữ offline bằng Hive + SQLite, giao diện thân thiện và hiệu ứng mượt mà.

---

## 📱 Tính năng chính

### 1. Danh sách sản phẩm
- Hiển thị danh sách sản phẩm (ảnh, tên, giá, tồn kho)
- Tìm kiếm theo tên (realtime)
- Lọc theo danh mục (dạng Chip List)
- Kéo xuống để làm mới (Pull to refresh)
- Hiển thị dữ liệu offline từ cache nếu mất mạng
- Thêm mới sản phẩm bằng nút `+`

### 2. Chi tiết sản phẩm
- Hiển thị ảnh dạng carousel
- Tên, mô tả, giá, tồn kho, danh mục
- Nút Chỉnh sửa & Xóa sản phẩm

### 3. Thêm/Sửa sản phẩm
- Form có validate từng trường
- Giới hạn hình ảnh: tối đa 5 ảnh (camera/gallery)
- Dữ liệu lưu trữ offline bằng Hive
- Upload ảnh dạng multipart nếu có API thật

---

## 🧱 Kiến trúc & Thư viện

Áp dụng kiến trúc **Clean Architecture** với các tầng:
- `domain/`: Entities, Repository interface, UseCase
- `data/`: Datasource, DTO model, Repository impl
- `presentation/`: UI + Cubit state
- `core/`: Exception, utils, widget tái sử dụng
- `app/`: Route, theme, DI config

### 📦 Thư viện chính

| Tên | Mục đích |
|-----|----------|
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management (Cubit) |
| [get_it](https://pub.dev/packages/get_it) | Dependency Injection |
| [go_router](https://pub.dev/packages/go_router) | Điều hướng |
| [hive](https://pub.dev/packages/hive), [hive_flutter](https://pub.dev/packages/hive_flutter) | Lưu trữ offline |
| [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) | Responsive UI |
| [lottie](https://pub.dev/packages/lottie), [animations](https://pub.dev/packages/animations) | Animation mượt mà |
| [json_serializable](https://pub.dev/packages/json_serializable), [freezed](https://pub.dev/packages/freezed) | Model generator |
| [dartz](https://pub.dev/packages/dartz) | Functional error handling (`Either`) |
| [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) | Log API |
| [mockito](https://pub.dev/packages/mockito) | Unit test mock |
| [animated_splash_screen](https://pub.dev/packages/animated_splash_screen) | Splash screen |

---

## ▶️ Hướng dẫn chạy app

### 1. Clone dự án
```bash
git clone https://github.com/tenban/flutter_product_manager.git
cd flutter_product_manager
```

### 2. Cài đặt dependencies
```bash
flutter pub get
```

### 3. Build file `*.g.dart` & `*.freezed.dart`
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Chạy app
```bash
flutter run
```

---

## 🔌 Mock API

Hiện tại app sử dụng file `json` mock trong thư mục `assets/mock/`, tích hợp với `DioClient` để giả lập API như sau:

- `GET /products` → `/assets/mock/products.json`
- `GET /categories` → `/assets/mock/categories.json`

Có thể mở rộng bằng cách tích hợp server thật sau.

---

## 📂 Cấu trúc thư mục

Tham khảo tại [structure.md](structure.md)

---

## 📸 Giao diện mẫu (Screenshots)

> (Thêm ảnh screenshot nếu muốn, ví dụ: `assets/screenshots/product_list.png`)

---

## ✍️ Tác giả

- 💼 Tên: Huỳnh Tấn Dũng
- 📧 Email: huynhtandung97dev@gmail.com
- 📁 Repo: https://github.com/huynhtandung97dev/FLUTTER_APP_TEST

---