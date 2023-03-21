//
//  CTGaugeShape.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-16.
//

import SwiftUI

public struct CTGaugeShape: Shape {
    var gaugeIndicationWidth: CGFloat
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.size.width / 2

        let outerCircleLeftPoint = CGPoint.pointOnCircle(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            angle: .degreesToRadians(-225)
        )

        let innerCircleLeftPoint = CGPoint(
            x: rect.midX + (radius - gaugeIndicationWidth) * cos(.degreesToRadians(-225)) ,
            y: rect.midY + (radius - gaugeIndicationWidth) * sin(.degreesToRadians(-225))
        )

        let point3 = outerCircleLeftPoint.midBetween(innerCircleLeftPoint)

        let point4 = CGPoint(
            x: rect.midX + (radius - gaugeIndicationWidth) * cos(.degreesToRadians(45)) ,
            y: rect.midY + (radius - gaugeIndicationWidth) * sin(.degreesToRadians(45))
        )

        let outerCircleRightPoint = CGPoint(
            x: rect.midX + radius * cos(.degreesToRadians(45)) ,
            y: rect.midY + radius * sin(.degreesToRadians(45))
        )

        let point6 = point4.midBetween(outerCircleRightPoint)

        path.move(
            to: CGPoint(
                x: rect.midX + radius * cos(.degreesToRadians(-225)) ,
                y: rect.midY + radius * sin(.degreesToRadians(-225))
            )
        )
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: .degrees(-225),
            endAngle: .degrees(45),
            clockwise: false
        )

        path.addArc(
            center: point6,
            radius: gaugeIndicationWidth / 2,
            startAngle: .degrees(45),
            endAngle: .degrees(225),
            clockwise: false
        )

        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius - gaugeIndicationWidth,
            startAngle: .degrees(45),
            endAngle: .degrees(-225),
            clockwise: true
        )

        path.addArc(
            center: point3,
            radius: gaugeIndicationWidth / 2,
            startAngle: .degrees(-45),
            endAngle: .degrees(135),
            clockwise: false
        )

        path.closeSubpath()

        return path
    }
}
