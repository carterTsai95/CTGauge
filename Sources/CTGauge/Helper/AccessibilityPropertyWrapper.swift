//
//  ScaledValue.swift
//
//
//  Created by Dima Koskin on 12.11.2022.
//
import SwiftUI


// MARK: - ScalledValue
/// A dynamic property that scales an arbitrary layout value based on the current Dynamic Type settings.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@propertyWrapper public struct ScaledValue<Value> where Value : Numeric, Value : Comparable {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @State private var value: Value
    
    private let minimumValue: Value?
    private let maximumValue: Value?
    private let textStyle: Font.TextStyle
    
    // MARK: Initializer
    
    /// Creates the scaled metric with an unscaled value bounded by minimum and maximum values,  and a text style to scale relative to.
    public init(
        wrappedValue defaultValue: Value,
        min minimumValue: Value? = nil,
        max maximumValue: Value? = nil,
        relativeTo textStyle: Font.TextStyle = .body)
    {
        self.textStyle = textStyle
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self._value = State(wrappedValue: defaultValue)
    }
    
    public var wrappedValue: Value {
        return value.between(minimumValue, maximumValue)
    }
    
    #if os(iOS)
    private var metrics: UIFontMetrics {
        UIFontMetrics(forTextStyle: textStyle.convertToSystemSpecificValue())
    }
    
    private var traits: UITraitCollection {
        UITraitCollection(preferredContentSizeCategory: dynamicTypeSize.convertToSystemSpecificValue())
    }
    #endif
}


extension ScaledValue where Value : BinaryFloatingPoint {
    
    // MARK: Wrapped Value for Floating Numbers
    
    public var wrappedValue: Value {
        #if os(iOS)
        let value = Double(metrics.scaledValue(for: CGFloat(self.value), compatibleWith: traits))
        #endif

        return Value(value).between(minimumValue, maximumValue)
    }
}


extension ScaledValue where Value : BinaryInteger {
    
    // MARK: Wrapped Value for Integers
    
    public var wrappedValue: Value {
        #if os(iOS)
        let value = Double(metrics.scaledValue(for: CGFloat(self.value), compatibleWith: traits))
        #endif
        
        return Value(value).between(minimumValue, maximumValue)
    }
}

import Foundation


internal extension Comparable {
    func minimum(_ lhs: Self, _ rhs: Self) -> Self {
        return lhs < rhs ? lhs : rhs
    }
    
    func maximum(_ lhs: Self, _ rhs: Self) -> Self {
        return lhs > rhs ? lhs : rhs
    }
    
    func between(_ minimumValue: Self? = nil, _ maximumValue: Self? = nil) -> Self {
        switch (minimumValue, maximumValue) {
        case (.some(let minimum), .some(let maximum)):
            return max(minimum, self.minimum(self, maximum))
        case (.none, .some(let maximum)):
            return self.minimum(self, maximum)
        case (.some(let minimum), .none):
            return self.maximum(minimum, self)
        case (.none, .none):
            return self
        }
    }
}

//
//  DynamicTypeSize+Convenience.swift
//
//
//  Created by Dima Koskin on 12.11.2022.
//
#if os(iOS)
import SwiftUI


@available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
internal extension DynamicTypeSize {
    func convertToSystemSpecificValue() -> UIContentSizeCategory {
        switch self {
        case .xSmall:
            return .extraSmall
        case .small:
            return .small
        case .medium:
            return .medium
        case .large:
            return .large
        case .xLarge:
            return .extraLarge
        case .xxLarge:
            return .extraExtraLarge
        case .xxxLarge:
            return .extraExtraExtraLarge
        case .accessibility1:
            return .accessibilityMedium
        case .accessibility2:
            return .accessibilityLarge
        case .accessibility3:
            return .accessibilityExtraLarge
        case .accessibility4:
            return .accessibilityExtraExtraLarge
        case .accessibility5:
            return .accessibilityExtraExtraExtraLarge
        @unknown default:
            fatalError("Unknown DynamicTypeSize")
        }
    }
}
#endif

#if os(iOS)
import SwiftUI


@available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
internal extension Font.TextStyle {
    func convertToSystemSpecificValue() -> UIFont.TextStyle {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption:
            return .caption1
        case .caption2:
            return .caption2
        @unknown default:
            fatalError("Unknown Font.TextStyle...")
        }
    }
}

@available(iOS 15.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
internal extension Font.Weight {
    func convertToSystemSpecificValue() -> UIFont.Weight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        default:
            fatalError("Unknown Font.Weight...")
        }
    }
}

@available(iOS 16.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, *)
internal extension Font.Width {
    func convertToSystemSpecificValue() -> UIFont.Width {
        switch self {
        case .compressed: return .compressed
        case .condensed: return .condensed
        case .expanded: return .expanded
        case .standard: return .standard
        default:
            fatalError("Unknown Font.Width...")
        }
    }
}

#endif

// MARK: - ScalledPointSize
/// A dynamic property that scales a font size value based on the current Dynamic Type settings.
@available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
@propertyWrapper public struct ScaledPointSize: DynamicProperty {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @State private var value: Double
    
    private let textStyle: Font.TextStyle
    private let minimumPointSize: Double?
    private let maximumPointSize: Double?
    
    // MARK: Initializer
    
    /// Creates the scaled metric with an unscaled font size value in points bounded by minimum and maximum values,  and a text style to scale relative to.
    public init(
        wrappedValue defaultValue: Double,
        min minimumPointSize: Double? = nil,
        max maximumPointSize: Double? = nil,
        relativeTo textStyle: Font.TextStyle = .body)
    {
        self.textStyle = textStyle
        self.minimumPointSize = minimumPointSize
        self.maximumPointSize = maximumPointSize
        self._value = State(wrappedValue: defaultValue)
    }
    
    // MARK: Wrapped Value
    
    public var wrappedValue: Double {
        #if os(iOS)
        let metrics = UIFontMetrics(forTextStyle: textStyle.convertToSystemSpecificValue())
        let traits = UITraitCollection(preferredContentSizeCategory: dynamicTypeSize.convertToSystemSpecificValue())
        let font = metrics.scaledFont(for: .systemFont(ofSize: value), compatibleWith: traits)
        let value = Double(font.pointSize)
        #endif

        return value.between(minimumPointSize, maximumPointSize)
    }
}
