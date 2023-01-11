//
//  AddSymptomViewController.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 6/1/2023.
//

import UIKit
import HealthKit
import HealthStore

//class AddSymptomViewModel {
//    var symptomTypes: [HKCategoryTypeIdentifier: Bool]
//
//    init(availableSymptoms: [HKCategoryTypeIdentifier], selectedSymptoms: [HKCategoryTypeIdentifier]) {
//        symptomTypes = availableSymptoms.reduce(into: [HKCategoryTypeIdentifier: Bool]) {
//            $0.
//    }
//}

class AddSymptomViewController: UIViewController {
    
    private enum Constants {
        static let cellReuseIdentifier = "cell"
    }
    
    private weak var coordinator: RootCoordinator?
    private weak var model: TrackedSymptomViewModel?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(coordinator: RootCoordinator, model: TrackedSymptomViewModel) {
        self.coordinator = coordinator
        self.model = model
       
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported for this view controller.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.fit(subView: tableView)
    }
}

extension AddSymptomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}

extension AddSymptomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
