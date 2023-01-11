//
//  SymptomListViewController.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 5/1/2023.
//

import UIKit
import HealthStore

class SymptomListViewController: UIViewController {
    
    private enum Constants {
        static let cellReuseIdentifier = "cell"
    }
    
    private weak var coordinator: RootCoordinator?
    private var model: TrackedSymptomViewModel
    
    private var addSymptomBarButton: UIBarButtonItem
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var emptyHelpView: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 0
        label.text = "Tap the '+' button to add your first tracked symptom."
        return label
    }()
    
    init(coordinator: RootCoordinator, healthStore: HealthStorable, configStore: ConfigurationStorable) {
        self.coordinator = coordinator
        self.model = TrackedSymptomViewModel(healthStore: healthStore, configStore: configStore)
        self.addSymptomBarButton = UIBarButtonItem()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported for this view controller.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func refreshTable() {
        addAppropriateContentView()
        if tableView.superview != nil {
            tableView.reloadSections(IndexSet(integer: .zero), with: .automatic)
        }
    }
    
    private func addAppropriateContentView() {
        if model.trackedSymptoms.count == 0 {
            tableView.removeFromSuperview()
            view.addSubview(emptyHelpView)
            emptyHelpView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                emptyHelpView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
                emptyHelpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyHelpView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -18)
            ])
        } else {
            emptyHelpView.removeFromSuperview()
            view.fit(subView: tableView)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        addAppropriateContentView()
        self.title = "Tracked Symptoms"
        self.addSymptomBarButton.target = self
        self.addSymptomBarButton.action = #selector(didTapAddTrackedSymptomButton)
        self.addSymptomBarButton.image = UIImage(systemName: "plus")
        self.navigationItem.rightBarButtonItem = self.addSymptomBarButton
    }
    
    @objc
    private func didTapAddTrackedSymptomButton() {
        coordinator?.navigateTo(.addTrackedSymptoms(model))
    }
}

extension SymptomListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.trackedSymptoms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath)
        let symptom = model.trackedSymptoms[indexPath.row]
        cell.textLabel?.text = symptom.name
        return cell
    }
    
    
}

extension SymptomListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateTo(.sampleEntry)
    }
}
