//
//  CTGaugeStyle+NeedleGaugeStyle.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-19.
//

import Foundation
import SwiftUI

/**
A needle gauge style for the CTGauge view.

This style represents the gauge as a circular arc with a needle that rotates around the center based on the gauge value.
*/
public struct NeedleGaugeStyle: CTGaugeStyle {
    public func makeBody(configuration: Configuration) -> some View {
        return ZStack {
            CTGaugeShape(gaugeIndicationWidth: configuration.gaugeIndicationWidth)
                .aspectRatio(1, contentMode: .fit)
                .frame(
                    width: configuration.gaugeLongestSide,
                    height: configuration.gaugeLongestSide,
                    alignment: .center
                )
                .foregroundStyle(
                    configuration.foregroundColor
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
                    // MARK: Needle's view
                    Rectangle()
                        .frame(
                            width: 1,
                            height: configuration.gaugeLongestSide / 2.3
                        )
                        .offset(
                            x: -(configuration.needleOffset.width / 2),
                            y: -(configuration.needleOffset.height / 2)
                        )
                        .rotationEffect(
                            .degrees(90)
                        )
                        .rotationEffect(
                            .radians(configuration.currentValueRadians)
                        )
                        .foregroundColor(configuration.needleColor)
                }

        }
    }
}
