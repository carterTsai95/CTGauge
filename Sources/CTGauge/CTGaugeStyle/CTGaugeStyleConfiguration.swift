//
//  CTGaugeStyleConfiguration.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-19.
//

import SwiftUI

public struct CTGaugeStyleConfiguration {
    /// A type-erased option view of a MinimumLabel.
    public struct MinimumLabel: View {
        init<Content: View>(content: Content) {
            body = AnyView(content)
        }
        
        public var body: AnyView
    }
    
    /// A type-erased option view of a MaximumLabel.
    public struct MaximumLabel: View {
        init<Content: View>(content: Content) {
            body = AnyView(content)
        }
        
        public var body: AnyView
    }

    public init(
        value: CGFloat,
        in bounds: ClosedRange<CGFloat> = 0...1,
        width: Double,
        height: Double,
        foregroundColor: AnyShapeStyle,
        indicatorColor: Color,
        needleColor: Color,
        minimumLabel: CTGaugeStyleConfiguration.MinimumLabel,
        maximumValueLabel: CTGaugeStyleConfiguration.MaximumLabel
    ) {
        self.value = value
        self.minValue = Double(bounds.lowerBound)
        self.maxValue = Double(bounds.upperBound)
        self.width = width
        self.height = height
        self.foregroundColor = foregroundColor
        self.indicatorColor = indicatorColor
        self.needleColor = needleColor
        self.minimumLabel = minimumLabel
        self.maximumLabel = maximumValueLabel
    }
    
    let minimumLabel: CTGaugeStyleConfiguration.MinimumLabel
    let maximumLabel: CTGaugeStyleConfiguration.MaximumLabel

    var value: CGFloat

    var width: Double

    var height: Double

    var foregroundColor: AnyShapeStyle

    var indicatorColor: Color

    var needleColor: Color
    
    var gaugeIndicationWidth: Double = 6

    var fontSize: CGFloat {
        gaugeLongestSide / 5
    }

    var gaugeLongestSide: CGFloat {
        return width >= height ? width : height
    }


    var needleOffset: CGSize {
        CGSize(
            width: leftCapPosition.x / 2 - gaugeIndicationWidth,
            height: leftCapPosition.y / 2
        )
    }

    private var radius: CGFloat {
        return gaugeLongestSide / 2
    }
    
    private var leftCapPosition: CGPoint {
        .pointOnCircle(
            center: CGPoint(
                x: gaugeLongestSide / 2,
                y: gaugeLongestSide / 2
            ),
            radius: radius - gaugeIndicationWidth / 2,
            angle: .degreesToRadians(-225)
        )
    }
    
    private var rightCapPosition: CGPoint {
        .pointOnCircle(
            center: CGPoint(
                x: gaugeLongestSide / 2,
                y: gaugeLongestSide / 2
            ),
            radius: radius - gaugeIndicationWidth / 2,
            angle: .degreesToRadians(45)
        )
    }
    
    var indicatorPosition: CGPoint {
        .pointOnCircle(
            center: CGPoint(
                x: gaugeLongestSide / 2,
                y: gaugeLongestSide / 2
            ),
            radius: radius - gaugeIndicationWidth / 2,
            angle: currentValueRadians
        )
    }

    var currentValueRadians: CGFloat {
        convertToRadians(
            value: Double(value),
            minValue: minValue,
            maxValue: maxValue
        )
    }

    private func convertToRadians(
        value: Double,
        minValue: Double,
        maxValue: Double
    ) -> CGFloat {
        let normalizedValue = (value - minValue) / (maxValue - minValue)
        let degreeRange = 45.0 - (-225.0)
        let normalizedDegreeValue = (normalizedValue * Double(degreeRange)) - Double(abs(-225.0))
        let degrees = normalizedDegreeValue > 180.0 ? normalizedDegreeValue - 360.0 : normalizedDegreeValue
        let radians = degrees / 180.0 * Double.pi
        return radians
    }
    
    private var minValue: CGFloat
    private var maxValue: CGFloat
}
