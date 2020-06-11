//
//  ProfileListViewController.swift
//  HingeTransitions
//
//  Created by Micah Benn on 6/6/19.
//  Copyright © 2020 Micah Benn. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileListDelegate: class {
    func showNextProfile()
}

class ProfileListViewController: UIViewController {
    var profiles: [String] = ["Apple", "Microsoft", "Google"]

    var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show Profile", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(showNextProfile), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self

        view.backgroundColor = .white
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ProfileListViewController: ProfileListDelegate {
    @objc func showNextProfile() {
        guard !profiles.isEmpty else { return }

        let profile = profiles.removeFirst()
        let vc = ProfileViewController(title: profile, delegate: self)

        navigationController?.pushViewController(vc, animated: true)

        button.isEnabled = !profiles.isEmpty
    }
}

extension ProfileListViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HingeTransition(operation: operation)
    }
}
