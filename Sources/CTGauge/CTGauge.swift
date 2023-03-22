//
//  CTGauge.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-11.
//

import SwiftUI

public struct CTGauge<V: BinaryFloatingPoint, BoundsLabel: View>: View {
    /// Initialize a gauge view without minimum and maximum value labels.
    /// - Parameters:
    ///   - value: The value to be shown on the gauge view.
    ///   - bounds: A closed range representing the minimum and maximum value of the gauge view.
    ///   - gaugeWidth: The width of the gauge. The default value is `60.0`.
    ///   - gaugeHeight: The height of the gauge. The default value is `60.0`.
    /// - Note: The minimum and maximum values of the gauge view are set to 0 and 1, respectively, and the gauge view will scale according to the width and height parameters.
    /// - Returns: A view of `CTGauge`.
    public init(
        value: V,
        in bounds: ClosedRange<V> = 0...1,
        gaugeWidth: Double = 60.0,
        gaugeHeight: Double = 60.0
    ) where BoundsLabel == EmptyView, V : BinaryFloatingPoint {
        self.value = value
        self.minValue = Double(bounds.lowerBound)
        self.maxValue = Double(bounds.upperBound)
        self._width = ScaledPointSize(
            wrappedValue: gaugeWidth, min: 60, max: 300, relativeTo: .body)
        self._height = ScaledPointSize(
            wrappedValue: gaugeWidth, min: 60, max: 300, relativeTo: .body)
        self.minimumValueLabel = EmptyView()
        self.maximumValueLabel = EmptyView()
    }
    
    /// Initialize a gauge view with minimum and maximum value labels.
    /// - Parameters:
    ///   - value: The value to be shown on the gauge view.
    ///   - bounds: A closed range representing the minimum and maximum value of the gauge view.
    ///   - gaugeWidth: The width of the gauge view.
    ///   - gaugeHeight: The height of the gauge view.
    ///   - minimumValueLabel: A closure that returns a view to show the minimum value label of the gauge view.
    ///   - maximumValueLabel: A closure that returns a view to show the maximum value label of the gauge view.
    public init(
        value: V,
        in bounds: ClosedRange<V> = 0...1,
        gaugeWidth: Double = 60.0,
        gaugeHeight: Double = 60.0,
        @ViewBuilder minimumValueLabel: () -> BoundsLabel,
        @ViewBuilder maximumValueLabel: () -> BoundsLabel
    ) where V : BinaryFloatingPoint {
        self.value = value
        self.minValue = Double(bounds.lowerBound)
        self.maxValue = Double(bounds.upperBound)
        self._width = ScaledPointSize(wrappedValue: gaugeWidth)
        self._height = ScaledPointSize(wrappedValue: gaugeWidth)
        self.minimumValueLabel = minimumValueLabel()
        self.maximumValueLabel = maximumValueLabel()
    }
    
    /// The style of the gauge view.
    @Environment(\.ctGaugeStyle) var style
    
    /// The foreground color of the gauge view.
    @Environment(\.ctForegroundColor) var foregroundColor
    
    /// The color of the gauge indicator.
    @Environment(\.ctGaugeIndicatorColor) var gaugeIndicatorColor
    
    /// The color of the gauge needle.
    @Environment(\.ctNeedleIndicatorColor) var gaugeNeedleColor
    
    let minimumValueLabel: BoundsLabel
    
    let maximumValueLabel: BoundsLabel
    
    var value: V
    
    private var minValue: CGFloat
    private var maxValue: CGFloat
    
    @ScaledPointSize(wrappedValue: 60, min: 60, max: 300, relativeTo: .body)
    var width: Double
    
    @ScaledPointSize(wrappedValue: 60, min: 60, max: 300, relativeTo: .body)
    var height: Double
    
    public var body: some View {
        VStack {
            style.makeBody(
                configuration: CTGaugeStyleConfiguration(
                    value: CGFloat(value),
                    in: minValue...maxValue,
                    width: width,
                    height: height,
                    foregroundColor: foregroundColor,
                    indicatorColor: gaugeIndicatorColor,
                    needleColor: gaugeNeedleColor,
                    minimumLabel: CTGaugeStyleConfiguration.MinimumLabel(content: minimumValueLabel),
                    maximumValueLabel: CTGaugeStyleConfiguration.MaximumLabel(content: maximumValueLabel)
                )
            )
        }
    }
}

struct PathTest_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}

public struct DemoView: View {
    @State var value = 0.0
    private let minValue = 0.0
    private let maxValue = 1.0
    
    public init(value: Double = 0.0) {
        self.value = value
    }
    
    public var body: some View {
        VStack {
            /// MARK: Top Gauge View
            CTGauge(value: value)
                .ctIndicatorColor(.red)
                .ctGaugeForegroundColor(
                    .angularGradient(
                        Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center, startAngle: .degrees(130), endAngle: .degrees(360)
                    )
                )
            
            /// MARK: Middle Gauge View
            CTGauge(
                value: value,
                in: 0...100
            ) {
                Text(minValue, format: .number)
            } maximumValueLabel: {
                Text(maxValue, format: .number)
            }
            .ctGaugeForegroundColor(
                .angularGradient(
                    Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center, startAngle: .degrees(130), endAngle: .degrees(360)
                )
            )
            .ctIndicatorColor(.black)
            
            
            /// MARK: Bottom Gauge View
            CTGauge(value: value) {
                Text(minValue, format: .number)
            } maximumValueLabel: {
                Text(maxValue, format: .number)
            }
            .ctGaugeStyle(.needleGauge)
            .ctNeedleColor(.red)
            
            Slider(value: $value, in: minValue...maxValue)
                .padding()
        }
    }
}
