//
//  StrokeAnimationView.swift
//  ChibaSwiftSlide
//
//  Created by Yugo Sugiyama on 2024/09/08.
//

import SwiftUI

struct StrokeAnimatableShape<S: Shape> {
    var animationProgress: CGFloat = 0
    let shape: S
}

extension StrokeAnimatableShape: Shape {
    var animatableData: CGFloat {
        get { animationProgress }
        set {
            if animationProgress >= 1.0 { return }
            animationProgress = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        return shape.path(in: rect)
            .trimmedPath(from: 0, to: animationProgress)
    }
}

struct StrokeAnimationShapeView<S: Shape>: View {
    let lineWidth: CGFloat
    let lineColor: Color
    let duration: Duration
    let shape: S
    let isPaused: Bool
    let fps: CGFloat = 60
    private var frameAddtionValue: CGFloat {
        return CGFloat(1 / (CGFloat(duration.components.seconds) * fps))
    }
    @State private var animationProgress: CGFloat = 0

    init(
        shape: S,
        lineWidth: CGFloat = 1,
        lineColor: Color = .black,
        duration: Duration = .seconds(10),
        isPaused: Bool = false
    ) {
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.duration = duration
        self.isPaused = isPaused
        self.shape = shape
    }

    var body: some View {
        TimelineView(.animation(paused: isPaused)) { context in
            StrokeAnimatableShape(
                animationProgress: animationProgress,
                shape: shape
            )
                .stroke(lineColor, lineWidth: lineWidth)
                .onChange(of: context.date) { oldValue, newValue in
                    animationProgress += frameAddtionValue
                }
        }
    }
}


#Preview {
    let duration = 100
    VStack {
        StrokeAnimationShapeView(
            shape: UhooiShape(),
            duration: .seconds(duration),
            isPaused: false
        )
        .aspectRatio(1, contentMode: .fit)
        StrokeAnimationShapeView(
            shape: PeanutsShape(),
            duration: .seconds(duration)
        )
        .aspectRatio(1, contentMode: .fit)
        StrokeAnimationShapeView(
            shape: ChibaShape(),
            duration: .seconds(duration)
        )
        .aspectRatio(1, contentMode: .fit)
    }
}
