//
//  CreateMonthlyBudgetController.swift
//  fintech
//
//  Created by Diogo on 24/07/2025.
//

import Foundation
import UIKit

class CreateMonthlyBudgetController: UIViewController {
    
    let contentView: CreateMonthlyBudgetView;
    weak var flowDelegate: CreateMonthlyBudgetFlowDelegate?
    
    init(
        contentView:CreateMonthlyBudgetView,
        flowDelegate: CreateMonthlyBudgetFlowDelegate?
    ){
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CreateMonthlyBudgetController: CreateMonthlyBudgetDelegate{
    func didTapSettingButton() {
        flowDelegate?.goToCreateMonthlyBudget()
    }
}
