//
//  SymptomListViewController.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 5/1/2023.
//

import UIKit
import HealthStore

protocol TrackedSymptomModelProvider: AnyObject {
    var model: TrackedSymptomViewModel { get }
}

class SymptomListViewController: UIViewController, TrackedSymptomModelProvider {
    
    private enum Constants {
        static let cellReuseIdentifier = "cell"
    }
    
    private weak var coordinator: RootCoordinator?
    
    var model: TrackedSymptomViewModel

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
        label.text = "Tap here to add your first tracked symptom"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapRecognizer)
        return label
    }()
    
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAddTrackedSymptomButton))
    
    private var editMode: Bool {
        get { tableView.isEditing }
        set {
            tableView.isEditing = newValue
            if newValue {
                
            }
        }
    }
    
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
        model.save()
    }
    
    private func addAppropriateContentView() {
        if model.trackedSymptoms.count == 0 {
            tableView.removeFromSuperview()
            view.addSubview(emptyHelpView)
            emptyHelpView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                emptyHelpView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
                emptyHelpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyHelpView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -18),
                emptyHelpView.heightAnchor.constraint(greaterThanOrEqualToConstant: 66)
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
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        coordinator?.navigateTo(.sampleEntry(indexPath.row))
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        if editing {
            self.navigationItem.leftBarButtonItem = self.addSymptomBarButton
        } else {
            self.navigationItem.leftBarButtonItem = nil
            addAppropriateContentView()
            model.save()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.trackedSymptoms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        model.trackedSymptoms.move(fromOffsets: IndexSet(integer: sourceIndexPath.row), toOffset: destinationIndexPath.row)
    }
}
