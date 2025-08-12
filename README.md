# SwiftToast
SwiftToast — A lightweight, customizable toast notification utility for iOS built with UIKit. Easily display quick feedback messages (success, error, warning, info, or normal) with smooth animations, icons, and flexible positioning (top, center, bottom).


// Default dark toast
CustomToast.show(message: "This is a normal toast")

// Error toast
CustomToast.show(message: "Something went wrong", type: .error)

// Success toast (top)
CustomToast.show(message: "Saved successfully", type: .success, position: .top)

// Warning toast (center)
CustomToast.show(message: "Low battery warning", type: .warning, position: .center)
