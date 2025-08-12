//
//  SwiftToast.swift
//  Created by Pavnesh kumar on 12/08/25.
//

import Foundation

class SwiftToast {
    
    enum ToastType {
        case normal       // Default dark background, white text, no icon
        case success
        case error
        case warning
        case info
        
        var backgroundColor: UIColor {
            switch self {
            case .normal:  return UIColor.black.withAlphaComponent(0.85)
            case .success: return UIColor.systemGreen.withAlphaComponent(0.9)
            case .error:   return UIColor.systemRed.withAlphaComponent(0.9)
            case .warning: return UIColor.systemOrange.withAlphaComponent(0.9)
            case .info:    return UIColor.systemBlue.withAlphaComponent(0.9)
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .normal:  return nil
            case .success: return UIImage(systemName: "checkmark.circle.fill")
            case .error:   return UIImage(systemName: "xmark.octagon.fill")
            case .warning: return UIImage(systemName: "exclamationmark.triangle.fill")
            case .info:    return UIImage(systemName: "info.circle.fill")
            }
        }
    }
    
    enum ToastPosition {
        case top, center, bottom
    }
    
    @discardableResult
    class func show(message: String,
                    type: ToastType = .normal,
                    duration: TimeInterval = 2.5,
                    position: ToastPosition = .center) -> UIView? {
        
        guard let window = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }),
            !message.isEmpty else { return nil }
        
        // Container
        let toastView = UIView()
        toastView.backgroundColor = type.backgroundColor
        toastView.layer.cornerRadius = 12
        toastView.layer.masksToBounds = true
        toastView.alpha = 0.0
        
        // Label
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let icon = type.icon {
            // Icon view
            let iconView = UIImageView(image: icon)
            iconView.tintColor = .white
            iconView.contentMode = .scaleAspectFit
            iconView.translatesAutoresizingMaskIntoConstraints = false
            
            let stack = UIStackView(arrangedSubviews: [iconView, label])
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 8
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            toastView.addSubview(stack)
            
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 10),
                stack.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -10),
                stack.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
                stack.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16),
                
                iconView.widthAnchor.constraint(equalToConstant: 20),
                iconView.heightAnchor.constraint(equalToConstant: 20)
            ])
        } else {
            toastView.addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 10),
                label.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -10),
                label.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16)
            ])
        }
        
        // Add toast to window
        window.addSubview(toastView)
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        // Position constraints
        var verticalConstraint: NSLayoutConstraint
        switch position {
        case .top:
            verticalConstraint = toastView.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: 20)
        case .center:
            verticalConstraint = toastView.centerYAnchor.constraint(equalTo: window.centerYAnchor)
        case .bottom:
            verticalConstraint = toastView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        }
        
        NSLayoutConstraint.activate([
            toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            toastView.leadingAnchor.constraint(greaterThanOrEqualTo: window.leadingAnchor, constant: 40),
            toastView.trailingAnchor.constraint(lessThanOrEqualTo: window.trailingAnchor, constant: -40),
            verticalConstraint
        ])
        
        // Animation: fade in → wait → fade out
        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
        
        return toastView
    }
}
