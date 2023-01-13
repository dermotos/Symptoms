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

    var symptomIndicatorView: SymptomIndicator
    let index: Int
    
    let gestureRecognizer: UIPanGestureRecognizer
    
    private var eventSubscribers = [AnyCancellable]()
    
    init(index: Int, initialSeverity: Severity = .notPresent) {
        self.index = index
        symptomIndicatorView = SymptomIndicator(severity: initialSeverity)
        gestureRecognizer = UIPanGestureRecognizer()
        super.init(rootView: symptomIndicatorView)
        gestureRecognizer.addTarget(self, action: #selector(didPan))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    var gestureStartPosition: CGFloat = 0
    var gestureStepSize: CGFloat = 80
    var lastStep: Int = 0
    var stepChange: Int = 0
    
    @objc
    func didPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            gestureStartPosition = recognizer.location(in: view).y
        case .changed:
            let positionChange = gestureStartPosition - recognizer.location(in: view).y
            //print("Position Change \(positionChange)")
            let step = Int(floor(positionChange / gestureStepSize))
            if step != stepChange {
                print("Step change: \(step)")
                stepChange = step
                //symptomIndicatorView.$severity.
                
            https://stackoverflow.com/questions/60085995/how-do-i-update-a-swiftui-view-in-uikit-when-value-changes
                
                // Likely need to create a published object and use combine to update the SwiftUI view via assign.
            }
        default:
            return
        }
    }
    
    private func incrementStep() {
        
    }
    
    private func decrementStep() {
        
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
