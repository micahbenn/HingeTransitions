//
//  ProfileViewController.swift
//  HingeTransitions
//
//  Created by Micah Benn on 6/6/19.
//  Copyright © 2020 Micah Benn. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    weak var delegate: ProfileListDelegate?

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()

    var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(dismissAndShowNextProfile), for: .touchUpInside)
        return button
    }()

    init(title: String, delegate: ProfileListDelegate) {
        super.init(nibName: nil, bundle: nil)
        label.text = title
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        view.addSubview(label)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }

    @objc func dismissAndShowNextProfile() {
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.delegate?.showNextProfile()
        }
        navigationController?.popViewController(animated: true)
        CATransaction.commit()
    }
}
