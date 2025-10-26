//
//  File.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 27.10.2025.
//

import SwiftUI

extension View {

    @ViewBuilder
    public func swipeActions(config: ActionConfig = .init(), @ActionBuilder actions: () -> [Action]) -> some View {
        self
            .modifier(CustomSwipeActionModifier(config: config, actions: actions()))
    }

    @ViewBuilder
    public func actionBackground(_ action: Action) -> some View {
        switch action.actionShape {
        case .circle:
            self.background(action.background, in: .circle)
        case .rectangle:
            self.background(action.background, in: .rect)
        case .rounded(let radius):
            self.background(action.background, in: .rect(cornerRadius: radius))
        }
    }

}
