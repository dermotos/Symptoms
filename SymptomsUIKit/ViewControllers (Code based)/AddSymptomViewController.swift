//
//  AddSymptomViewController.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 6/1/2023.
//

import UIKit
import HealthKit
import HealthStore

class AddSymptomViewController: UIViewController {
    
    private enum Constants {
        static let cellReuseIdentifier = "cell"
    }
    
    private weak var coordinator: RootCoordinator?
    private weak var model: TrackedSymptomViewModel?
    
    private var doneButton: UIBarButtonItem
    
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
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
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
        
        self.title = "Trackable Symptoms"
        self.doneButton.target = self
        self.doneButton.action = #selector(didTapDone)
        self.navigationItem.rightBarButtonItem = self.doneButton
    }
    
    @objc
    private func didTapDone() {
        model?.save()
        coordinator?.navigateTo(.root)
    }
}

extension AddSymptomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.supportedSymptoms.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath)
        guard let model = model else {
            //TODO: Log null reference error
            return UITableViewCell()
        }
        let symptom = model.supportedSymptoms[indexPath.row]
        cell.accessoryType = model.trackedSymptoms.contains(symptom) ? .checkmark : .none
        cell.textLabel?.text = symptom.name
        return cell
    }
    
    
}

extension AddSymptomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = model else { return }
        let symptom = model.supportedSymptoms[indexPath.row]
        if model.trackedSymptoms.contains(symptom) {
            model.trackedSymptoms.removeAll { $0 == symptom }
        } else {
            model.trackedSymptoms.append(symptom)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
