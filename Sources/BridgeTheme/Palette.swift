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
    public enum ColorArgument {
      case `static`(_ hex: String, _ alpha: Double = Double.nan)
      case `invert`(_ hex: String, _ alpha: Double = Double.nan)
      case `dynamic`(_ lightHex: String, _ darkHex: String, _ alpha: Double = Double.nan)
    }

    /// Color storage.
    public struct Vector {
      /// The red value of the color object.
      public let red: Double
      /// The green value of the color object.
      public let green: Double
      /// The blue value of the color object.
      public let blue: Double
      /// The alpha value of the color object.
      public let alpha: Double
      /// Construct a color from a hexadecimal string.
      public init(_ vector: SIMD4<Double>) {
        red = vector[0]
        green = vector[1]
        blue = vector[2]
        alpha = vector[3]
      }
    }
    private let argument: ColorArgument
    /// The color storage.
    private let lightStorage: Vector
    private let darkStorage: Vector

    /// The associated `UIColor`
    public var uiColor: UIColor {
      let v = AppDarkModeEnabled ? darkStorage : lightStorage
      return  UIColor(
        red: CGFloat(v.red),
        green: CGFloat(v.green),
        blue: CGFloat(v.blue),
        alpha: CGFloat(v.alpha))
    }
    /// Returns a `Color` token.
    @available(iOS 13.0, *)
    public var color: SwiftUI.Color {
      let v = AppDarkModeEnabled ? darkStorage : lightStorage
      return SwiftUI.Color(.displayP3, red: v.red, green: v.green, blue: v.blue, opacity: v.alpha)
    }

    public init(_ hexString: String) {
      self.init(.static(hexString, 1))
    }

    public init(_ argument: ColorArgument) {
      self.argument = argument
      switch argument {
      case .static(let hex, let alpha):
        lightStorage = Vector(SIMD4(hex, alpha))
        darkStorage = lightStorage
      case .invert(let hex, let alpha):
        lightStorage = Vector(SIMD4(hex, alpha))
        darkStorage = Vector(SIMD4(hex, alpha).inverRGB())
      case .dynamic(let lightHex, let darkHex, let alpha):
        lightStorage = Vector(SIMD4(lightHex, alpha))
        darkStorage = Vector(SIMD4(darkHex, alpha))
      }
    }

    /// Returns a new color with the desired alpha component.
    public func withAlphaComponent(_ alpha: Double) -> Palette.Color {
      switch argument {
      case .static(let hex, _):
        return Palette.Color(.static(hex, alpha))
      case .invert(let hex, _):
        return Palette.Color(.invert(hex, alpha))
      case .dynamic(let lightHex, let darkHex, _):
        return Palette.Color(.dynamic(lightHex, darkHex, alpha))
      }
    }
  }
}


public protocol PaletteProtocol {
  var background: Palette.Color { get }
  var surface: Palette.Color { get }
  var light: Palette.Color { get }
  var dark: Palette.Color { get }
  var black: Palette.Color { get }
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

public extension UIColor {
  /// Returns an image with solid color.
  func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
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

extension SIMD4 where Scalar == Double {
  /// Builds a SIMD4 from a RGB color.
  init(_ hexString: String, _ alpha: Double) {
    func norm(_ value: UInt32) -> Double {
      return Double(value) / 255
    }
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    var a, r, g, b: UInt32
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
    a = 255
    if alpha >= 0 && alpha <= 1 {
      a = UInt32(alpha * 255)
    }
    let (dr, dg, db, da) = (norm(r), norm(g), norm(b), norm(a))
    self.init(dr, dg, db, da)
  }

  /// Returns the color associated to the inverted RGB color.
  func inverRGB() -> SIMD4<Double> {
    return SIMD4(1 - self[0], 1 - self[1], 1 - self[2], self[3])
  }
}

