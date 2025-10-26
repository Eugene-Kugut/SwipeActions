//
//  PanGesture.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import SwiftUI

struct PanGestureValue {
    var translation: CGSize = .zero
    var velocity: CGSize = .zero
}

extension CGPoint {
    var tosize: CGSize {
        return CGSize(width: x, height: y)
    }
}

@available(iOS 18, *)
struct PanGesture: UIGestureRecognizerRepresentable {
    var onBegan: () -> ()
    var onChange: (PanGestureValue) -> ()
    var onEnded: (PanGestureValue) -> ()

    func makeCoordinator(converter: CoordinateSpaceConverter) -> Coordinator {
        Coordinator()
    }

    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        gesture.delegate = context.coordinator
        return gesture
    }

    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {
    }

    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        let state = recognizer.state
        let translation = recognizer.translation(in: recognizer.view).tosize
        let velocity = recognizer.velocity(in: recognizer.view).tosize
        let gestureValue = PanGestureValue(translation: translation, velocity: velocity)

        switch state {
        case .began:
            onBegan()
        case .changed:
            onChange(gestureValue)
        case .ended, .cancelled:
            onEnded(gestureValue)
        default:
            break
        }
    }

    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
                let velocity = panGesture.velocity(in: panGesture.view)
                return abs(velocity.x) > abs(velocity.y)
            }

            return false
        }

    }

}
