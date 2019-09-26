import UIKit

/// Example theme bundled with this package.

// MARK: - Default typography

@available(iOS 10, *)
public class DefaultTypography: TypographyProtocol {
  public let primaryFontFamily: Typography.FontNameProvider? = { weight in
    switch weight {
    case .light:
      return "Rubik-Light"
    case .medium:
      return "Rubik-Medium"
    default:
      return "Rubik-Regular"
    }
  }
  public let secondaryFontFamily: Typography.FontNameProvider? = { weight in
    return UIFont.systemFont(ofSize: 1, weight: weight.fontWeight).familyName
  }

  public func style(_ scale: Typography.Style) -> Typography.StyleDescriptor {
    switch scale {
    case .h1:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .primary, weight: .light, size: 97.54),
        kern: -1.5)
    case .h2: return
      Typography.StyleDescriptor(
        font: Typography.font(family: .primary, weight: .light, size: 60.96),
        kern: -0.5)
    case .h3:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .primary, weight: .regular, size: 48.77),
        kern: 0)
    case .h4:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .primary, weight: .regular, size: 34.54),
        kern: 0.25)
    case .h5:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .primary, weight: .medium, size: 24.38),
        kern: 0)
    case .h6:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .primary, weight: .light, size: 14.26),
        kern: 0.25)
    case .body1:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .secondary, weight: .regular, size: 14.26),
        kern: 0.5,
        supportDynamicType: true)
    case .body2:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .secondary, weight: .regular, size: 12.22),
        kern: 0.25,
        supportDynamicType: true)
    case .subtitle1:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .secondary, weight: .medium, size: 16.25),
        kern: 0.15,
        supportDynamicType: true)
    case .subtitle2:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .secondary, weight: .medium, size: 14.22),
        kern: 0.1,
        supportDynamicType: true)
    case .button:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .primary, weight: .medium, size: 12.22),
        kern: 1.25,
        uppercase: true,
        supportDynamicType: true)
    case .caption:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .secondary, weight: .regular, size: 12.19),
        kern: 0.4,
        supportDynamicType: true)
    case .overline:
      return Typography.StyleDescriptor(
        font: Typography.font(family: .primary, weight: .medium, size: 12.19),
        kern: 2,
        uppercase: true,
        supportDynamicType: true)
    }
  }
}

// MARK: - Default palette

@available(iOS 10, *)
public class DefaultPalette: PaletteProtocol {
  public let background = Palette.Color(.invert("#ffffff"))
  public let surface = Palette.Color(.invert("#f8f9fa"))
  public let light = Palette.Color("#ffffff")
  public let dark = Palette.Color("#f1f3f4")
  public let black = Palette.Color("#130c0c")
  public let text = Palette.Color(.invert("#130c0c"))
  public let textHigh = Palette.Color(.invert("#000000"))
  public let textDisabled = Palette.Color(.invert("#000000")).withAlphaComponent(0.38)
  public let hairline = Palette.Color("#dadce0")

  public func primary(_ style: Palette.Style) -> Palette.Color {
    switch style {
    case .tintBase:
      return Palette.Color("#5f6368")
    case .tint900:
      return Palette.Color("#202124")
    case .tint800:
      return Palette.Color("#3c4043")
    case .tint700:
      return Palette.Color("#5f6368")
    case .tint600:
      return Palette.Color("#80868b")
    case .tint500:
      return Palette.Color("#9aaca6")
    case .tint400:
      return Palette.Color("#bdc1c6")
    case .tint300:
      return Palette.Color("#dadce0")
    case .tint200:
      return Palette.Color("#e8eaed")
    case .tint100:
      return Palette.Color("#f1f3f4")
    case .tint50:
      return Palette.Color("#f8f9fa")
    case .text:
      return text
    case .textHigh:
      return textHigh
    case .textDisabled:
      return textDisabled
    case .invertedText:
      return Palette.Color("#ffffff").withAlphaComponent(0.60)
    case .invertedTextHigh:
      return Palette.Color("#ffffff")
    case .invertedTextDisabled:
      return Palette.Color("#ffffff").withAlphaComponent(0.38)
    }
  }

  public func secondary(_ style: Palette.Style) -> Palette.Color {
    switch style {
    case .tintBase:
      return Palette.Color("#f15258")
    case .tint900:
      return Palette.Color("#ba1625")
    case .tint800:
      return Palette.Color("#c92430")
    case .tint700:
      return Palette.Color("#d62b38")
    case .tint600:
      return Palette.Color("#e8353e")
    case .tint500:
      return Palette.Color("#f73e3f")
    case .tint400:
      return Palette.Color("#f15158")
    case .tint300:
      return Palette.Color("#e67379")
    case .tint200:
      return Palette.Color("#ef9a9e")
    case .tint100:
      return Palette.Color("#ffcdd5")
    case .tint50:
      return Palette.Color("#ffebef")
    case .text:
      return Palette.Color("#f15258")
    case .textHigh:
      return Palette.Color("#f15258")
    case .textDisabled:
      return Palette.Color("#000000").withAlphaComponent(0.38)
    case .invertedText:
      return Palette.Color("#ffffff").withAlphaComponent(0.60)
    case .invertedTextHigh:
      return Palette.Color("#ffffff")
    case .invertedTextDisabled:
      return Palette.Color("#ffffff").withAlphaComponent(0.38)
    }
  }
}
