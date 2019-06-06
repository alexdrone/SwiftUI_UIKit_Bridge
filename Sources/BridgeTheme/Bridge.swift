import UIKit
#if canImport(SwiftUI)
import SwiftUI
#endif

public extension UIColor {
  /// Returns this color as a `SwiftUI.Color`.
  @available(iOS 13.0, *)
  var color: SwiftUI.Color {
    let c = cgColor.components ?? [0, 0, 0]
    let (r, g, b) = (Double(c[0]), Double(c[1]), Double(c[2]))
    let alpha = Double(cgColor.alpha)
    return SwiftUI.Color(.displayP3, red: r, green: g, blue: b, opacity: alpha)
  }
}

public extension UIFont {
  // Returns this font as a `SwiftUI.Font`.
  @available(iOS 13.0, *)
  var font: SwiftUI.Font {
    return SwiftUI.Font.custom(fontName, size: pointSize)
  }
}

/// Returns a SwiftUI.Text object that uses the desired `Theme.typography`.
@available(iOS 13.0, *)
public func StyledText(_ string: String, style: Typography.Style) -> SwiftUI.Text {
  return AppTypography.style(style).asTextView(string)
}
