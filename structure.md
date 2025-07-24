# 📁 Cấu trúc thư mục Flutter

```
lib/
│
├── app/                         # Khởi tạo app, route, theme, dependency injection
│   ├── app.dart                 # Widget gốc MyApp
│   ├── router/                 # Cấu hình go_router
│   │   ├── app_router.dart
│   │   └── routes.dart
│   ├── theme/                  # Light / Dark theme
│   │   ├── app_theme.dart
│   │   └── colors.dart
│   ├── di/                     # Inject Cubit, Repository, Service
│   │   └── di.dart
│   └── config/                 # Cấu hình chung
│       ├── constants.dart
│       └── env.dart
│
├── core/                        # Core logic dùng chung
│   ├── error/                   # Xử lý lỗi: Failure, Exception
│   ├── usecase/                 # BaseUseCase interface
│   ├── utils/                   # Helper / extension / formatter
│   └── widgets/                 # Widget dùng lại nhiều nơi
│       └── app_dialog.dart
│
├── data/                        # Tầng Data: gọi API, lưu Hive, mapping Model
│   ├── datasources/             # API và Local
│   │   ├── remote/              # Gọi API mock
│   │   │   ├── api_service.dart
│   │   │   └── product_api.dart
│   │   └── local/               # Hive database
│   │       ├── hive_helper.dart
│   │       └── product_hive.dart
│   ├── models/                  # Dto model từ API (khác với entity)
│   │   ├── product_model.dart
│   │   └── category_model.dart
│   └── repositories/           # Triển khai Repository
│       └── product_repository_impl.dart
│
├── domain/                      # Tầng domain: business logic
│   ├── entities/                # Định nghĩa đối tượng chính (Product, Category)
│   │   ├── product.dart
│   │   └── category.dart
│   ├── repositories/           # Interface cho repository
│   │   └── product_repository.dart
│   └── usecases/               # Các use case: GetProductList, CreateProduct, ...
│       └── get_products_usecase.dart
│
├── presentation/               # UI + Cubit
│   ├── product/                # Feature chính: Quản lý sản phẩm
│   │   ├── cubit/              # State management
│   │   │   └── product_cubit.dart
│   │   ├── screens/            # Các màn hình UI
│   │   │   ├── product_list_screen.dart
│   │   │   ├── product_detail_screen.dart
│   │   │   └── product_form_screen.dart
│   │   └── widgets/            # UI component riêng (form, card,...)
│   │       ├── product_card.dart
│   │       └── product_form.dart
│   └── splash/                 # Màn hình splash ban đầu (nếu có)
│       └── splash_screen.dart
│
└── main.dart                   # Hàm main khởi chạy
```