//
//  SwipeActionSharedData.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import SwiftUI

@MainActor
@Observable
class SwipeActionSharedData {
    static let shared = SwipeActionSharedData()
    var activeSwipeAction: String?
}
