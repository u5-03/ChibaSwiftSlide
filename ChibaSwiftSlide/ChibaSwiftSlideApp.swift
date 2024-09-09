//
//  ChibaSwiftSlideApp.swift
//  ChibaSwiftSlide
//
//  Created by Yugo Sugiyama on 2024/09/08.
//

import SwiftUI
import SlideKit

@main
struct ChibaSwiftSlideApp: App {
    static let configuration = SlideConfiguration()
    @Environment(\.openWindow) var openWindow

    var presentationContentView: some View {
        SlideRouterView(slideIndexController: Self.configuration.slideIndexController)
            .slideTheme(Self.configuration.theme)
            .foregroundColor(.black)
            .background(.white)
    }

    var body: some Scene {
        WindowGroup {
            PresentationView(slideSize: Self.configuration.size) {
                presentationContentView
            }
        }
#if os(macOS)
        .setupAsPresentationWindow(Self.configuration.slideIndexController) {
            openWindow(id: "presenter")
        }
        .addPDFExportCommands(for: presentationContentView, with: Self.configuration.slideIndexController, size: Self.configuration.size)
#endif
#if os(macOS)
        WindowGroup(id: "presenter") {
            VStack {
                macOSPresenterView(
                    slideSize: Self.configuration.size,
                    slideIndexController: Self.configuration.slideIndexController
                ) {
                    presentationContentView
                }
            }
        }
        .setupAsPresenterWindow()
#endif
    }
}

struct SlideConfiguration {

    /// Edit the slide size.
    let size = SlideSize.standard16_9

    let slideIndexController = SlideIndexController(index: 0) {
        CenterTextSlide(text: "iOSDC2024")
        CenterTextSlide(text: "今年はLTをしました")
        CenterTextSlide(text: "ピアノの発表でしたけど、スライド上で\nアニメーションで結構遊んだ")
        MusicNoteAnimationSlide()
        CenterTextSlide(text: "今回はこの線を描くアニメーションの\n仕組みを解説します")
        TitleSlide()
        ChibaContentSlide()
        AnimationStructureSlide()
        CodeSlide(
            title: "実際のコード1",
            code: Constants.strokeAnimatableShapeCodeCode,
            fontSize: 40
        )
        CodeSlide(
            title: "実際のコード2",
            code: Constants.strokeAnimationShapeViewCode,
            fontSize: 38
        )
        CenterTextSlide(text: "なるほど")
        CenterTextSlide(text: "これでいい感じにアニメーションできそう")
        CenterTextSlide(text: "ではこれで遊んでみましょう！")
        QuizTitleSlide()
        QuizDescriptionSlide()
        CenterTextSlide(text: "第1問")
        QuizAnimationSlide(title: "千葉シンボルクイズ 第1問", answer: "ピーナッツ", shape: PeanutsShape())
        CenterTextSlide(text: "第2問")
        QuizAnimationSlide(title: "千葉シンボルクイズ 第2問", answer: "チーバくん", shape: ChibaShape())
        CenterTextSlide(text: "第3問")
        CenterTextSlide(text: "最終問題はなんと100ポイント！")
        QuizAnimationSlide(title: "千葉シンボルクイズ 第3問", answer: "uhooi", shape: UhooiShape())
        CenterTextSlide(text: "優勝したHogeさん、\nおめでとうございます！🎉")
        CenterTextSlide(text: "優勝賞品は...")
        WinningPrizeSlide()
        WrapUpSlide()
        CenterTextSlide(text: "おしまい")

    }

    let theme = CustomSlideTheme()
}

struct CustomSlideTheme: SlideTheme {
    let headerSlideStyle = CustomHeaderSlideStyle()
    let itemStyle = CustomItemStyle()
    let indexStyle = CustomIndexStyle()
}

struct CustomIndexStyle: IndexStyle {
    func makeBody(configuration: Configuration) -> some View {
        Text("\(configuration.slideIndexController.currentIndex + 1) / \(configuration.slideIndexController.slides.count)")
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .font(.system(size: 30))
            .padding()
    }
}
