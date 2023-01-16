//
//  SymptomIndicatorHostViewController.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 13/1/2023.
//

import UIKit
import SwiftUI
import Combine

class SymptomIndicatorHostViewController: UIHostingController<SymptomIndicator> {
    
    enum Direction {
        case upwards
        case downwards
    }

    var symptomIndicatorView: SymptomIndicator
    let index: Int
    
    var gestureStart: CGFloat = 0
    let gestureStep: CGFloat = 50
    var gestureLastStep: Int = 0
    let gestureRecognizer: UIPanGestureRecognizer
    private var eventSubscribers = [AnyCancellable]()
    
    init(index: Int, initialSeverity: Severity = .notPresent) {
        self.index = index
        symptomIndicatorView = SymptomIndicator(severity: initialSeverity, sliderLevel: 3)
        gestureRecognizer = UIPanGestureRecognizer()
        super.init(rootView: symptomIndicatorView)
        gestureRecognizer.addTarget(self, action: #selector(didPan))
        
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    @objc
    private func didPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            gestureStart = recognizer.location(in: nil).y
        case .changed:
            let step = Int((gestureStart - recognizer.location(in: nil).y) / gestureStep)
            //print(step)
            if step != gestureLastStep {
                let direction: Direction = step < gestureLastStep ? .downwards : .upwards
                updateSymptomView(moving: direction)
                gestureLastStep = step
            }
        default: return
        }
        
    }
    
    func updateSymptomView(moving direction: Direction) {
        switch direction {
        case .upwards: symptomIndicatorView.increment()
        case .downwards: symptomIndicatorView.decrement()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(gestureRecognizer)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

enum GestureType {
    case tap(UITapGestureRecognizer = .init())
    case swipe(UISwipeGestureRecognizer = .init())
    case longPress(UILongPressGestureRecognizer = .init())
    case pan(UIPanGestureRecognizer = .init())
    case pinch(UIPinchGestureRecognizer = .init())
    case edge(UIScreenEdgePanGestureRecognizer = .init())
    func get() -> UIGestureRecognizer {
        switch self {
        case let .tap(tapGesture):
            return tapGesture
        case let .swipe(swipeGesture):
            return swipeGesture
        case let .longPress(longPressGesture):
            return longPressGesture
        case let .pan(panGesture):
            return panGesture
        case let .pinch(pinchGesture):
            return pinchGesture
        case let .edge(edgePanGesture):
            return edgePanGesture
       }
    }
}

//struct PanGesturePublisher: Publisher {
//
//    typealias Output = CGFloat
//    typealias Failure = Never
//
//    private var view: UIView
//    private var gestureRecognizer: UIPanGestureRecognizer
//
//    init(onView view: UIView) {
//        gestureRecognizer = UIPanGestureRecognizer()
//
//    }
//
//    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, CGFloat == S.Input {
//
//    }
//}
//
//class PanGestureSubscription<S: Subscriber>: Subscription where S.Input == CGFloat, S.Failure == Never {
//    private var subscriber: S?
//    private var offset: CGFloat
//    private var view: UIView
//
//    init(subscriber: S, view: UIView) {
//        self.subscriber = subscriber
//        self.offset = 0
//        self.view = view
//        configureGesture()
//    }
//
//    func configureGesture() {
//
//    }
//}

struct GesturePublisher: Publisher {
    typealias Output = GestureType
    typealias Failure = Never
    private let view: UIView
    private let gestureType: GestureType
    init(view: UIView, gestureType: GestureType) {
        self.view = view
        self.gestureType = gestureType
    }
    func receive<S>(subscriber: S) where S : Subscriber,
    GesturePublisher.Failure == S.Failure, GesturePublisher.Output
    == S.Input {
        let subscription = GestureSubscription(
            subscriber: subscriber,
            view: view,
            gestureType: gestureType
        )
        subscriber.receive(subscription: subscription)
    }
}

class GestureSubscription<S: Subscriber>: Subscription where S.Input == GestureType, S.Failure == Never {
    private var subscriber: S?
    private var gestureType: GestureType
    private var view: UIView
    init(subscriber: S, view: UIView, gestureType: GestureType) {
        self.subscriber = subscriber
        self.view = view
        self.gestureType = gestureType
        configureGesture(gestureType)
    }
    private func configureGesture(_ gestureType: GestureType) {
        let gesture = gestureType.get()
        gesture.addTarget(self, action: #selector(handler))
        view.addGestureRecognizer(gesture)
    }
    func request(_ demand: Subscribers.Demand) { }
    func cancel() {
        subscriber = nil
    }
    @objc
    private func handler() {
        _ = subscriber?.receive(gestureType)
    }
}

struct SteppedGesture {
    let startPosition: CGFloat = 0
    let stepSize: CGFloat = 80
    var lastStep: Int = 0
    var stepChange: Int = 0
    
//    @objc
//    func didPan(recognizer: UIPanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            gestureStartPosition = recognizer.location(in: view).y
//        case .changed:
//            let positionChange = gestureStartPosition - recognizer.location(in: view).y
//            //print("Position Change \(positionChange)")
//            let step = Int(floor(positionChange / gestureStepSize))
//            if step != stepChange {
//                print("Step change: \(step)")
//                stepChange = step
//                //symptomIndicatorView.$severity.
//
//            //https://stackoverflow.com/questions/60085995/how-do-i-update-a-swiftui-view-in-uikit-when-value-changes
//
//                // Likely need to create a published object and use combine to update the SwiftUI view via assign.
//            }
//        default:
//            return
//        }
//    }
//
//    private func incrementStep() {
//
//    }
//
//    private func decrementStep() {
//
//    }
}
