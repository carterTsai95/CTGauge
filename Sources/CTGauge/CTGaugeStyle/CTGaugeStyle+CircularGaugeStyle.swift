//
//  CTGaugeStyle+CircularGaugeStyle.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-19.
//

import SwiftUI

/**
A circular gauge style for the CTGauge view.

This style represents the gauge as a circular arc with an indicator dot that moves along the arc based on the gauge value.
*/
public struct CircularGaugeStyle: CTGaugeStyle {
    public func makeBody(configuration: Configuration) -> some View {
        return ZStack {
            CTGaugeShape(gaugeIndicationWidth: configuration.gaugeIndicationWidth)
                .style(withStroke: Color.red, fill: configuration.foregroundColor)
                .aspectRatio(1, contentMode: .fit)
                .frame(
                    width: configuration.gaugeLongestSide,
                    height: configuration.gaugeLongestSide,
                    alignment: .center
                )
                .overlay(
                    alignment: .bottom
                ) {
                    HStack {
                        Spacer()
                        configuration.minimumLabel
                            .font(.system(size: configuration.fontSize))
                            .lineLimit(1)
                            .minimumScaleFactor(0.3)
                            .frame(width: configuration.gaugeLongestSide / 5)
                        Spacer()
                        configuration.maximumLabel
                            .font(.system(size: configuration.fontSize))
                            .lineLimit(1)
                            .minimumScaleFactor(0.3)
                            .frame(width: configuration.gaugeLongestSide / 5)
                        Spacer()
                    }
                }
                .overlay {
                    Circle()
                        .frame(
                            width: configuration.gaugeIndicationWidth,
                            height: configuration.gaugeIndicationWidth
                        )
                        .position(
                            x: configuration.indicatorPosition.x,
                            y: configuration.indicatorPosition.y
                        )
                        .foregroundStyle(configuration.indicatorColor)

                    Text(configuration.value, format: .number)
                        .font(.title)
                        .lineLimit(1)
                        .frame(width: configuration.gaugeLongestSide - configuration.gaugeIndicationWidth * 2.5)
                        .minimumScaleFactor(0.1)
                }

        }
    }
}
