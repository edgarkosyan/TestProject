//
//  Extensions.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import Foundation
import SwiftUI

extension UIDevice {
    var hasNotch: Bool {
        UIDevice.safeAreaBottom() > 0 ? true : false
    }
    
    class func safeAreaBottom() -> CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
    
    class func safeAreaTop() -> CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Int {
    func format() -> String {
        var result: String = ""
        if String(self).count == 1 {
            result = "0\(self)"
        } else {
            result = "\(self)"
        }
        return result
    }
}
