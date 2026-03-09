# Flutter POS UI Kit 🏪

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.22-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-3.4-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Material_3-6750A4?style=for-the-badge&logo=materialdesign&logoColor=white" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" />
</p>

> A beautiful, production-ready Flutter UI kit for Point-of-Sale (POS) applications. Features product grid, cart sidebar, checkout flow, and receipt screen — all built with Material 3 theming and dark/light mode support.

## ✨ Features

- 🛒 **Product Grid** — Responsive grid with search, categories, and quick-add
- 📦 **Cart Sidebar** — Live cart with quantity controls and running total
- 💳 **Checkout Flow** — Payment method selection, discount, and confirmation
- 🧾 **Receipt Screen** — Printable receipt with QR code
- 🌙 **Dark/Light Mode** — Material 3 dynamic theming
- 📱 **Responsive** — Works on tablets and phones
- ⚡ **State Management** — Clean Provider/Riverpod architecture

## 🚀 Quick Start

```bash
git clone https://github.com/iamahsanmehmood/flutter-pos-ui-kit.git
cd flutter-pos-ui-kit
flutter pub get
flutter run
```

## 🗂️ Project Structure

```
lib/
├── main.dart
├── models/
│   └── product.dart          # Product, CartItem, Order models
├── screens/
│   ├── pos_screen.dart       # Main POS screen with grid + cart
│   ├── checkout_screen.dart  # Payment & confirmation
│   └── receipt_screen.dart   # Order receipt
├── widgets/
│   ├── product_card.dart     # Product grid card
│   ├── cart_sidebar.dart     # Cart panel
│   └── category_chips.dart   # Category filter chips
└── theme/
    └── app_theme.dart        # Material 3 theme configuration
```

## 💡 Built For

This UI kit powers the frontend of **RestoCare+ POS** and **MartCare POS** — production POS systems serving 50+ restaurants and retail stores across Pakistan.

## 👤 Author

**Ahsan Mehmood** — [LinkedIn](https://www.linkedin.com/in/iamahsanmehmood/) · [GitHub](https://github.com/iamahsanmehmood) · [XechTech](https://xechtech.com)

## 📄 License

MIT License
