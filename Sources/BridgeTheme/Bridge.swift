import UIKit

#if canImport(SwiftUI)
  import SwiftUI
#endif

extension UIColor {
  /// Returns this color as a `SwiftUI.Color`.
  @available(iOS 13.0, *)
  public var color: SwiftUI.Color {
    let c = cgColor.components ?? [0, 0, 0]
    let (r, g, b) = (Double(c[0]), Double(c[1]), Double(c[2]))
    let alpha = Double(cgColor.alpha)
    return SwiftUI.Color(.displayP3, red: r, green: g, blue: b, opacity: alpha)
  }
}

extension UIFont {
  // Returns this font as a `SwiftUI.Font`.
  @available(iOS 13.0, *)
  public var font: SwiftUI.Font {
    return SwiftUI.Font.custom(fontName, size: pointSize)
  }
}

/// Returns a SwiftUI.Text object that uses the desired `AppTypography`.
@available(iOS 13.0, *)
public func StyledText(
  _ style: Typography.Style,
  key: LocalizedStringKey
) -> SwiftUI.Text {
  return AppTypography.style(style).asTextView(key: key)
}

/// Returns a SwiftUI.Text object that uses the desired `AppTypography`.
@available(iOS 13.0, *)
public func StyledText(
  _ style: Typography.Style,
  verbatim: String
) -> SwiftUI.Text {
  return AppTypography.style(style).asTextView(verbatim: verbatim)
}
