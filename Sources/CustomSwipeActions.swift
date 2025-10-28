//
//  CustomSwipeActions.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import SwiftUI

struct CustomSwipeActionModifier: ViewModifier {
    var config: ActionConfig
    var actions: [Action]

    @State private var resetPositionTrigger: Bool = false
    @State private var offsetX: CGFloat = 0
    @State private var lastStoredOffsetX: CGFloat = 0
    @State private var bounceOffset: CGFloat = 0
    @State private var progress: CGFloat = 0

    @State private var currentScrollOffset: CGFloat = 0
    @State private var storedScrollOffset: CGFloat?
    @State private var currentID: String = UUID().uuidString
    var sharedData: SwipeActionSharedData = .shared

    private var alignment: Alignment {
        switch config.alignment {
        case .top:
            return .topTrailing
        case .center:
            return .trailing
        default:
            return .bottomTrailing
        }
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle()
                    .fill(.clear)
                    .containerRelativeFrame(config.occupiesFullWidth ? .horizontal : .init())
                    .overlay(alignment: alignment) {
                        ActionsView()
                            .padding(.top, config.topPadding)
                            .padding(.bottom, config.bottomPadding)
                    }
            }
            .compositingGroup()
            .offset(x: offsetX)
            .offset(x: bounceOffset)
            .mask {
                Rectangle()
                    .containerRelativeFrame(config.occupiesFullWidth ? .horizontal : .init())
            }
            .gesture(
                PanGesture(onBegan: {
                    gestureDidBegan()
                }, onChange: {value in
                    gestureDidChange(translation: value.translation)
                }, onEnded: {value in
                    gestureDidEnded(translation: value.translation, velocity: value.velocity)
                })
            )
            .onChange(of: resetPositionTrigger) { oldValue, newValue in
                reset()
            }
            .onGeometryChange(for: CGFloat.self) {
                $0.frame(in: .scrollView).minY
            } action: { newValue in
                if let storedScrollOffset, storedScrollOffset != newValue {
                    reset()
                }
            }
            .onChange(of: sharedData.activeSwipeAction) { oldValue, newValue in
                if newValue != currentID && offsetX != 0 {
                    reset()
                }
            }
    }

    @ViewBuilder func actionView(for action: Action, size: CGSize) -> some View {
        Image(systemName: action.symbolImage)
            .font(action.font)
            .fontWeight(action.fontWeight)
            .foregroundStyle(action.tint)
            .frame(width: size.width, height: size.height)
            .actionBackground(action, config: config)
    }

    @ViewBuilder private func ActionsView() -> some View {
        ZStack(content: {
            ForEach(actions.indices, id: \.self) { index in
                let action = actions[index]
                GeometryReader {proxy in
                    let size = proxy.size
                    let spacing = config.spacing * CGFloat(index)
                    let offset = (CGFloat(index) * size.width) + spacing
                    Button(action: {
                        action.action(&resetPositionTrigger)
                    }, label: {
                        actionView(for: action, size: size)
                    })
                    .buttonStyle(.plain)
                    .offset(x: offset * progress)

                }.frame(width: config.size.width, height: config.size.height)
            }
        })
        .visualEffect { content, proxy in
            content
                .offset(x: proxy.size.width)
        }
        .offset(x: config.leadingPadding)
    }

    private func gestureDidBegan() {
        storedScrollOffset = lastStoredOffsetX
        sharedData.activeSwipeAction = currentID
    }

    private func gestureDidChange(translation: CGSize) {
        offsetX = min(max(translation.width + lastStoredOffsetX, -maxOffsetWidth), 0)
        progress = -offsetX / maxOffsetWidth
        bounceOffset = min(translation.width - (offsetX - lastStoredOffsetX), 0) / 10
    }

    private func gestureDidEnded(translation: CGSize, velocity: CGSize) {
        let endTarget = velocity.width + offsetX
        if -endTarget > (maxOffsetWidth * 0.6) {
            withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                offsetX = -maxOffsetWidth
                bounceOffset = 0
                progress = 1
            }
        } else {
            reset()
        }

        lastStoredOffsetX = offsetX
    }

    private func reset() {
        withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
            offsetX = 0
            lastStoredOffsetX = 0
            progress = 0
            bounceOffset = 0
        }

        storedScrollOffset = nil
    }

    var maxOffsetWidth: CGFloat {
        if actions.count == 0 {
            return 0
        }

        let totalActionSize: CGFloat = CGFloat(actions.count) * config.size.width
        let spacing = CGFloat(actions.count - 1) * config.spacing

        return totalActionSize + spacing + config.leadingPadding + config.trailingPadding
    }
}
