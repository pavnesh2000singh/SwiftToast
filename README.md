# SwiftToast

SwiftToast — A lightweight, customizable toast notification utility for iOS built with UIKit.  
Easily display quick feedback messages (success, error, warning, info, or normal) with smooth animations, icons, and flexible positioning (top, center, bottom).

## 📌 Installation

Simply drag and drop `CustomToast.swift` into your Xcode project.  
No external dependencies required.

## 📌 Usage

```swift
// Default dark toast
CustomToast.show(message: "This is a normal toast")

// Error toast
CustomToast.show(message: "Something went wrong", type: .error)

// Success toast (top)
CustomToast.show(message: "Saved successfully", type: .success, position: .top)

// Warning toast (center)
CustomToast.show(message: "Low battery warning", type: .warning, position: .center)
```

💡 **Tip:**  
You can also customize the `duration` and choose between `.top`, `.center`, or `.bottom` positions.

## 🎨 Customization

`CustomToast` supports different styles through the `ToastType` enum:
- `.normal` — Dark background, white text
- `.success` — Green background with checkmark icon
- `.error` — Red background with cross icon
- `.warning` — Orange background with warning icon
- `.info` — Blue background with info icon

Toast positions:
- `.top`
- `.center`
- `.bottom`

## 📄 License

This project is licensed under the MIT License — feel free to use in your own projects.
