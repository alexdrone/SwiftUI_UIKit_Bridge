import UIKit

/// The theme palette.
/// Override this static property to override the application palette.
@available(iOS 10, *)
public var AppPalette: PaletteProtocol = DefaultPalette()
/// The theme typography.
/// Override this static property to override the application typography.
@available(iOS 10, *)
public var AppTypography: TypographyProtocol = DefaultTypography()
