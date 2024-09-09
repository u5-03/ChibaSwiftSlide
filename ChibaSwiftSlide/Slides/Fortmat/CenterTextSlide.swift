//
//  CenterTextSlide.swift
//  ChibaSwiftSlide
//
//  Created by Yugo Sugiyama on 2024/09/08.
//


import SwiftUI
import SlideKit

@Slide
struct CenterTextSlide: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.largeFont)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.defaultForegroundColor)
            .background(.slideBackgroundColor)

    }
}

#Preview {
    SlidePreview {
        CenterTextSlide(text: "CenterText")
    }
}

