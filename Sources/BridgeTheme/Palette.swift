import UIKit

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
}

public protocol PaletteProtocol {
  var surface: UIColor { get }
  var light: UIColor { get }
  var dark: UIColor { get }
  var text: UIColor { get }
  var textHigh: UIColor { get }
  var textDisabled: UIColor { get }
  var hairline: UIColor { get }

  /// Returns all of the colors that belong to the primary swatch.
  func primary(_ style: Palette.Style) -> UIColor
  /// Returns all of the colors that belong to the secondary swatch.
  func secondary(_ style: Palette.Style) -> UIColor
}

public extension PaletteProtocol {

}

// MARK: - Internals

extension UIColor {

  /// Construct a color from a hexadecimal string.
  convenience init(_ hexString: String) {
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
    self.init(
      red: CGFloat(r) / 255,
      green: CGFloat(g) / 255,
      blue: CGFloat(b) / 255,
      alpha: CGFloat(a) / 255)
  }

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
