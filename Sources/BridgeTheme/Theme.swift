import UIKit
#if canImport(SwiftUI)
import SwiftUI
#endif

/// The theme palette.
/// Override this static property to define the application palette.
@available(iOS 13, *)
public var AppPalette: PaletteProtocol = DefaultPalette()
/// The theme typography.
/// Override this static property to define the application typography.
@available(iOS 13, *)
public var AppTypography: TypographyProtocol = DefaultTypography()
/// Whether dark mode is currently enabled system-wide.
public var AppDarkModeEnabled: Bool {
  if #available(iOS 13.0, *) {
    return UIScreen.main.traitCollection.userInterfaceStyle == .dark
  }
  return false
}

@available(iOS 13.0, *)
public extension View {
  /// Returns the current app palette.
  var palette: PaletteProtocol {
    return AppPalette
  }
  /// Returns the current app typography.
  var typography: TypographyProtocol {
    return AppTypography
  }
}
