//
//  ViewExtensions.swift
//
//  Created by Dermot O Sullivan on 31/1/17.
//

import Foundation
import UIKit

enum FitOrientation {
    case horizontally
    case vertically
    case horizontallyAndVertically
}

extension UIView {
    /** Center the provided view in current view by adding necessary constraints, and adding the view as a subview, if needed.
     - parameter view: The subview to be added. Must have intrinsic size or height and width manually set.
     
     */
    func center(subView view:UIView, _ orientation:FitOrientation = .horizontallyAndVertically) {
        if view.superview != self {
            self.addSubview(view)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        if orientation == .horizontally || orientation == .horizontallyAndVertically {
            let constraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview!, attribute: .centerX, multiplier: 1.0, constant: 0)
            addConstraint(constraint)
        }
        
        if orientation == .vertically || orientation == .horizontallyAndVertically {
            let constraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview!, attribute: .centerY, multiplier: 1.0, constant: 0)
            addConstraint(constraint)
        }
    }
    
    
    /** Fit the provided view in current view by adding necessary constraints, and adding the view as a subview, if needed */
    func fit(subView view:UIView, _ orientation:FitOrientation = .horizontallyAndVertically, with padding:UIEdgeInsets = UIEdgeInsets.zero) {
        if view.superview != self {
            self.addSubview(view)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .horizontally || orientation == .horizontallyAndVertically {
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding.left)-[subview]-\(padding.right)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": view]))
        }
        
        if orientation == .vertically || orientation == .horizontallyAndVertically {
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding.top)-[subview]-\(padding.bottom)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": view]))
        }
    }
}

