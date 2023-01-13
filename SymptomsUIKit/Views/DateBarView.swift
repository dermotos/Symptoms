//
//  DateBarView.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 6/1/2023.
//

import UIKit

//private final class DateBarViewTouchHandler {
//    weak var target: UIResponder?
//    var gestureRecognizer = UITapGestureRecognizer()
//
//    init(target: UIResponder? = nil) {
//        self.target = target
//        //gestureRecognizer.addTarget(self, action: #())
//    }
//
//    @objc
//    private func userDidTap() {
//
//    }
//
//}

final class DateBarView: UIView {
    
    private(set) var sampleEntryDate = Date()
    private(set) var previousEntryDate: Date?
    
    func updateSampleEntryLabel(to newDate: Date) {
        
    }
    
    func updatePreviousEntryLabel(to newDate: Date?) {
        

    }
    
    private var sampleEntryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.backgroundColor = .clear
        label.textColor = .label
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
        return label
    }()
    
    private var sampleEntryDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        return picker
    }()
    
    private var previousEntryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.backgroundColor = .clear
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private func setupView() {
        backgroundColor = .systemPink
        addSubview(sampleEntryDatePicker)
        addSubview(previousEntryLabel)
        sampleEntryDatePicker.translatesAutoresizingMaskIntoConstraints = false
        previousEntryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sampleEntryDatePicker.topAnchor.constraint(equalTo: topAnchor, constant: Constants.spacing),
            sampleEntryDatePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            sampleEntryDatePicker.widthAnchor.constraint(equalTo: widthAnchor, constant: -Constants.spacing * 2),
            
            sampleEntryDatePicker.bottomAnchor.constraint(equalTo: previousEntryLabel.topAnchor, constant: Constants.spacing),
            previousEntryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            previousEntryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.spacing),
            previousEntryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.spacing)
        ])
    }
    
    private enum Constants {
        static let spacing: CGFloat = 8
    }
    
}
