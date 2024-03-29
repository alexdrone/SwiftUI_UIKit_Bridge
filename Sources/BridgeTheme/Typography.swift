import UIKit

#if canImport(SwiftUI)
  import SwiftUI
#endif

@available(iOS 13, *)
public class Typography {
  /// Scale text in your interface automatically by using Dynamic Type and `UIFontMetrics`.
  public static var enableDynamicType: Bool = true

  /// - returns: The font name for the given weight.
  /// - note: A `nil` provider results in the system font.
  public typealias FontNameProvider = (FontWeight) -> String

  /// Represents the desired font weight.
  public enum FontWeight: String {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black

    /// Returns the associated *UIFontWeight* value.
    public var fontWeight: UIFont.Weight {
      switch self {
      case .ultraLight:
        return UIFont.Weight.ultraLight
      case .thin:
        return UIFont.Weight.thin
      case .light:
        return UIFont.Weight.light
      case .regular:
        return UIFont.Weight.regular
      case .medium:
        return UIFont.Weight.medium
      case .semibold:
        return UIFont.Weight.semibold
      case .bold:
        return UIFont.Weight.bold
      case .heavy:
        return UIFont.Weight.heavy
      case .black:
        return UIFont.Weight.black
      }
    }
  }

  /// Target the desired font family.
  public enum Family: String {
    case primary
    case secondary
  }

  /// Typographic scale.
  public enum Style: String {
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case body1
    case body2
    case subtitle1
    case subtitle2
    case button
    case caption
    case overline
  }

  /// Short-hand font constructor.
  public static func font(family: Family, weight: FontWeight = .regular, size: CGFloat) -> UIFont {
    var provider: Typography.FontNameProvider? = nil
    switch family {
    case .primary:
      provider = AppTypography.primaryFontFamily
    case .secondary:
      provider = AppTypography.secondaryFontFamily
    }
    let primaryDesc = UIFont.systemFont(ofSize: size, weight: weight.fontWeight)
      .fontDescriptor.withDesign(.rounded)
    let secondaryDesc = UIFont.systemFont(ofSize: size, weight: weight.fontWeight).fontDescriptor
    let desc = family == .primary ? primaryDesc : secondaryDesc
    guard let fontProvider = provider else {
      return UIFont(descriptor: desc!, size: size)
    }
    return UIFont(name: fontProvider(weight), size: size) ?? UIFont.systemFont(ofSize: size)
  }

  /// Fonts and its attributes.
  public struct StyleDescriptor {
    /// The typeface.
    private let internalFont: UIFont

    /// The font letter spacing.
    private let kern: CGFloat

    /// Whether this typeface is meant to be used with uppercased text.
    private var uppercase: Bool

    /// Whether this font support dybamic font size.
    private var supportDynamicType: Bool

    /// The font color.
    public var color: Palette.Color

    /// Publicly exposed font (subject to font scaling if appliocable).
    public var font: UIFont {
      guard enableDynamicType, supportDynamicType else {
        return internalFont
      }
      if #available(iOS 11.0, *) {
        return UIFontMetrics.default.scaledFont(for: internalFont)
      } else {
        return internalFont
      }
    }

    public init(
      font: UIFont,
      kern: CGFloat,
      uppercase: Bool = false,
      supportDynamicType: Bool = false,
      color: Palette.Color = AppPalette.text
    ) {
      self.internalFont = font
      self.kern = kern
      self.uppercase = uppercase
      self.supportDynamicType = supportDynamicType
      self.color = color
    }

    /// Returns a dictionary of attributes for `NSAttributedString`.
    public var attributes: [NSAttributedString.Key: Any] {
      return [
        NSAttributedString.Key.font: font,
        NSAttributedString.Key.foregroundColor: color.uiColor,
        NSAttributedString.Key.kern: kern,
      ]
    }

    /// Override the `NSForegroundColorAttributeName` attribute.
    public func withColor(_ override: Palette.Color) -> StyleDescriptor {
      return StyleDescriptor(
        font: internalFont,
        kern: kern,
        uppercase: uppercase,
        supportDynamicType: supportDynamicType,
        color: override)
    }

    /// Returns an attributed string with the current font descriptor attributes.
    public func asAttributedString(_ string: String) -> NSAttributedString {
      let displayString = uppercase ? string.uppercased() : string
      return NSAttributedString(string: displayString, attributes: attributes)
    }

    /// Returns a `SwiftUI.Text` view configured with this style descriptor.
    @available(iOS 13.0, *)
    public func asTextView(key: LocalizedStringKey) -> SwiftUI.Text {
      return Text(key)
        .font(
          Font(
            CTFontCreateWithFontDescriptor(
              internalFont.fontDescriptor, internalFont.pointSize, nil)))
        .kerning(kern)
    }

    /// Returns a `SwiftUI.Text` view configured with this style descriptor.
    @available(iOS 13.0, *)
    public func asTextView(verbatim: String) -> SwiftUI.Text {
      return Text(verbatim: verbatim)
        .font(
          Font(
            CTFontCreateWithFontDescriptor(
              internalFont.fontDescriptor, internalFont.pointSize, nil)))
        .kerning(kern)
    }
  }
}

@available(iOS 13, *)
public protocol TypographyProtocol {
  /// Returns the primary font provider.
  var primaryFontFamily: Typography.FontNameProvider? { get }

  /// Returns the secondary font provider.
  var secondaryFontFamily: Typography.FontNameProvider? { get }

  /// Return the font style for the given typographic scale argument.
  func style(_ scale: Typography.Style) -> Typography.StyleDescriptor
}
