import UIKit
#if canImport(SwiftUI)
import SwiftUI
#endif

public struct Palette {
  /// Swatch styles.
  public enum Style: String {
    case tintBase
    case tint900
    case tint800
    case tint700
    case tint600
    case tint500
    case tint400
    case tint300
    case tint200
    case tint100
    case tint50
    case text
    case textHigh
    case textDisabled
    case invertedText
    case invertedTextHigh
    case invertedTextDisabled
  }

  public struct Color {
    /// The original hex string.
    private let hexString: String
    /// The red value of the color object.
    public let red: Double
    /// The green value of the color object.
    public let green: Double
    /// The blue value of the color object.
    public let blue: Double
    /// The alpha value of the color object.
    public let alpha: Double
    /// The associated `UIColor`
    public let uiColor: UIColor
    /// Returns a `Color` token.
    @available(iOS 13.0, *)
    public var color: SwiftUI.Color {
      return SwiftUI.Color(.displayP3, red: red, green: green, blue: blue, opacity: alpha)
    }

    /// Construct a color from a hexadecimal string.
    public init(_ hexString: String, alpha: Double = Double.nan) {
      self.hexString = hexString
      let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
      var int = UInt32()
      Scanner(string: hex).scanHexInt32(&int)
      let a, r, g, b: UInt32
      switch hex.count {
      case 3: // RGB (12-bit)
        (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
      case 6: // RGB (24-bit)
        (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
      case 8: // ARGB (32-bit)
        (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
      default:
        (a, r, g, b) = (255, 0, 0, 0)
      }
      self.red = Double(r) / 255
      self.green = Double(g) / 255
      self.blue = Double(b) / 255
      if alpha >= 0 && alpha <= 1 {
        self.alpha = alpha
      } else {
        self.alpha = Double(a) / 255
      }
      self.uiColor = UIColor(
        red: CGFloat(self.red),
        green: CGFloat(self.green),
        blue: CGFloat(self.blue),
        alpha: CGFloat(self.alpha))
    }
    /// Returns a new color with the desired alpha component.
    public func withAlphaComponent(_ alpha: Double) -> Palette.Color {
      return Palette.Color(hexString, alpha: alpha)
    }
  }
}

public protocol PaletteProtocol {
  var surface: Palette.Color { get }
  var light: Palette.Color { get }
  var dark: Palette.Color { get }
  var text: Palette.Color { get }
  var textHigh: Palette.Color { get }
  var textDisabled: Palette.Color { get }
  var hairline: Palette.Color { get }

  /// Returns all of the colors that belong to the primary swatch.
  func primary(_ style: Palette.Style) -> Palette.Color
  /// Returns all of the colors that belong to the secondary swatch.
  func secondary(_ style: Palette.Style) -> Palette.Color
}

// MARK: - Internals

extension UIColor {
  /// Returns an image with solid color.
  public func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    if #available(iOS 10.0, *) {
      return UIGraphicsImageRenderer(size: size).image { rendererContext in
        self.setFill()
        rendererContext.fill(CGRect(origin: .zero, size: size))
      }
    } else {
      return UIImage()
    }
  }
}
