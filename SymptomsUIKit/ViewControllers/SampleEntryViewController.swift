//
//  SampleEntryViewController.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 5/1/2023.
//

import UIKit
import SwiftUI

/// A view controller that accepts a symptom severity sample from the user.
class SampleEntryViewController: UIViewController {
    
    private enum Constants {
        static let buttonContainerPadding = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        static let buttonHeight: CGFloat = 50
        static let defaultSpacing: CGFloat = 8
    }
    
    private let dateBarView = DateBarView()
    private let modelProvider: TrackedSymptomModelProvider
    private let startingIndex: Int
    
    private lazy var indicatorViewControllers = {
        let controllers = modelProvider.model.trackedSymptoms.map { item in
            let controller = UIViewController()
            let colors: [UIColor] = [.red, .blue, .orange, .green]
            controller.view.backgroundColor = colors[Int.random(in: 0..<colors.count)]
            return controller
        }
        return controllers
    }()
    
    private lazy var pageViewController = {
        let controller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        controller.dataSource = self
        controller.setViewControllers([indicatorViewControllers.first!], direction: .forward, animated: false)
        return controller
    }()
    
    private let buttonBarView = UIView()
    
    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .tintColor
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Save", for: .normal)
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        button.layer.cornerRadius = Constants.buttonHeight / 2
        return button
    }()
    
    init(modelProvider: TrackedSymptomModelProvider, startingIndex: Int) {
        self.modelProvider = modelProvider
        self.startingIndex = startingIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.systemBackground

        addChild(pageViewController)
        [dateBarView, pageViewController.view, buttonBarView].forEach {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        buttonBarView.fit(subView: button,with: Constants.buttonContainerPadding)
        
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        dateBarView.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            dateBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageViewController.view.topAnchor.constraint(equalTo: dateBarView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonBarView.topAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            buttonBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//    private func addSymptomIndicatorView() {
//        let trackedSymptoms = modelProvider.model.trackedSymptoms
//        indicatorViewControllers
//    }
}

extension SampleEntryViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("view controller before called")
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("view controller after called")
        return nil
    }
}

