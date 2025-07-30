//
//  NewTransactionController.swift
//  fintech
//
//  Created by Diogo on 20/07/2025.
//

import Foundation
import UIKit

class NewTransactionController: UIViewController {
    
    var contentView: NewTransaction
    var viewModel: NewTransactionViewModel
    
    init(
        contentView: NewTransaction,
        viewModel: NewTransactionViewModel,
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
     
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        contentView.delegate = self
        setupContentView()
        configureSheet()
                
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurView, at: 0)
    }


    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func configureSheet() {
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
    }
}

extension NewTransactionController: NewTransactionDelegate {
    func didTapSaveTransaction(transaction: Transaction) {
        viewModel.add(transaction: transaction)
        print(viewModel.store.transactions);
        self.dismiss(animated: true, completion: nil)
    }
}
    
