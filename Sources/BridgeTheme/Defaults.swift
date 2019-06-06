import UIKit

// MARK: - Default typography

@available(iOS 10, *)
public class DefaultTypography: TypographyProtocol {
  public let primaryFontFamily: Typography.FontNameProvider? = { weight in
    switch weight {
    case .light:
      return ".SFUIRounded-Ultrathin"
    case .regular:
      return ".SFUIRounded-Regular"
    case .medium:
      return ".SFUIRounded-Semibold"
    }
  }
  public let secondaryFontFamily: Typography.FontNameProvider? = nil

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
  public let surface = UIColor("#f8f9fa")
  public let light = UIColor("#ffffff")
  public let dark = UIColor("#f1f3f4")
  public let text = UIColor("#130c0c")
  public let textHigh = UIColor("#000000")
  public let textDisabled = UIColor("#000000").withAlphaComponent(0.38)
  public let hairline = UIColor("#dadce0")

  public func primary(_ style: Palette.Style) -> UIColor {
    switch style {
    case .tintBase:
      return UIColor("#5f6368")
    case .tint900:
      return UIColor("#202124")
    case .tint800:
      return UIColor("#3c4043")
    case .tint700:
      return UIColor("#5f6368")
    case .tint600:
      return UIColor("#80868b")
    case .tint500:
      return UIColor("#9aaca6")
    case .tint400:
      return UIColor("#bdc1c6")
    case .tint300:
      return UIColor("#dadce0")
    case .tint200:
      return UIColor("#e8eaed")
    case .tint100:
      return UIColor("#f1f3f4")
    case .tint50:
      return UIColor("#f8f9fa")
    case .text:
      return text
    case .textHigh:
      return textHigh
    case .textDisabled:
      return textDisabled
    case .invertedText:
      return UIColor("#ffffff").withAlphaComponent(0.60)
    case .invertedTextHigh:
      return UIColor("#ffffff")
    case .invertedTextDisabled:
      return UIColor("#ffffff").withAlphaComponent(0.38)
    }
  }

  public func secondary(_ style: Palette.Style) -> UIColor {
    switch style {
    case .tintBase:
      return UIColor("#f15258")
    case .tint900:
      return UIColor("#ba1625")
    case .tint800:
      return UIColor("#c92430")
    case .tint700:
      return UIColor("#d62b38")
    case .tint600:
      return UIColor("#e8353e")
    case .tint500:
      return UIColor("#f73e3f")
    case .tint400:
      return UIColor("#f15158")
    case .tint300:
      return UIColor("#e67379")
    case .tint200:
      return UIColor("#ef9a9e")
    case .tint100:
      return UIColor("#ffcdd5")
    case .tint50:
      return UIColor("#ffebef")
    case .text:
      return UIColor("#f15258")
    case .textHigh:
      return UIColor("#f15258")
    case .textDisabled:
      return UIColor("#000000").withAlphaComponent(0.38)
    case .invertedText:
      return UIColor("#ffffff").withAlphaComponent(0.60)
    case .invertedTextHigh:
      return UIColor("#ffffff")
    case .invertedTextDisabled:
      return UIColor("#ffffff").withAlphaComponent(0.38)
    }
  }
}
