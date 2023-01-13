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
    
    var sampleEntryDate: Date {
        sampleEntryDatePicker.date
    }
    
    private var sampleEntryDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        return picker
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
        sampleEntryDatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sampleEntryDatePicker.topAnchor.constraint(equalTo: topAnchor, constant: Constants.spacing),
            sampleEntryDatePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            sampleEntryDatePicker.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.spacing)
        ])
    }
    
    private enum Constants {
        static let spacing: CGFloat = 8
    }
    
}
