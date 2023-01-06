//
//  SampleEntryViewController.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 5/1/2023.
//

import UIKit

/// A view controller that accepts a symptom severity sample from the user.
class SampleEntryViewController: UIViewController {
    
    private enum Constants {
        static let buttonContainerPadding = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        static let buttonHeight: CGFloat = 50
        static let defaultSpacing: CGFloat = 8
    }
    
    private let dateBarView = DateBarView()

    private let pagerView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let buttonBarView = UIView()
    
    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.tertiarySystemBackground
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.setTitle("Next", for: .normal)
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        button.layer.cornerRadius = Constants.buttonHeight / 2
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(dateBarView)
        view.addSubview(pagerView)
        view.addSubview(buttonBarView)
        buttonBarView.fit(subView: button,with: Constants.buttonContainerPadding)
        
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pagerView.topAnchor.constraint(equalTo: dateBarView.bottomAnchor),
            pagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonBarView.topAnchor.constraint(equalTo: pagerView.bottomAnchor),
            buttonBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
