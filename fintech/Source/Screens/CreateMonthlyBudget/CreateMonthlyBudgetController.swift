//
//  CreateMonthlyBudgetController.swift
//  fintech
//
//  Created by Diogo on 24/07/2025.
//

import Foundation
import UIKit

class CreateMonthlyBudgetController: UIViewController {

    let contentView: CreateMonthlyBudgetView
    let viewModel: CreateMonthlyBudgetViewModel
    weak var flowDelegate: CreateMonthlyBudgetFlowDelegate?

    init(
        contentView: CreateMonthlyBudgetView,
        viewModel: CreateMonthlyBudgetViewModel,
        flowDelegate: CreateMonthlyBudgetFlowDelegate?
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
        setup()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        view.addSubview(contentView)
        contentView.backgroundColor = Colors.gray100
        contentView.viewDelegate = self
        contentView.budgetsTableView.delegate = self
        contentView.budgetsTableView.dataSource = self

        if let picker = contentView.monthYearTextField.inputView as? UIPickerView {
            picker.delegate = self
            picker.dataSource = self
        }

        setupConstraints()
    }

    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CreateMonthlyBudgetController: CreateMonthlyBudgetDelegate {
    func didTapAddBudget(monthYear: String, budget: String) {
        print("Adding budget for \(monthYear) with value \(budget)")
    }
}

extension CreateMonthlyBudgetController: UITableViewDelegate, UITableViewDataSource {
    @objc
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.store.getAllBudgets().count
    }

    @objc(tableView:cellForRowAtIndexPath:)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath)
        let budget = viewModel.store.getAllBudgets()[indexPath.row]
        cell.textLabel?.text = "\(budget.month): \(budget.limit)"
        return cell
    }
}

extension CreateMonthlyBudgetController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String?
    {
        if component == 0 {
            return viewModel.months[row]
        } else {
            return "\(viewModel.years[row])"
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return viewModel.months.count
        case 1:
            return viewModel.years.count
        default:
            return 0

        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            contentView.selectedMonth = viewModel.months[row]

        } else {
            contentView.selectedYear = viewModel.years[row]
        }
       
      // quero atualizar o campo de texto com o mês e ano selecionados e fechar o picker
        
        if contentView.selectedMonth != nil && contentView.selectedYear != nil {
            contentView.monthYearTextField.text = "\(contentView.selectedMonth) \(contentView.selectedYear)"
            contentView.monthYearTextField.resignFirstResponder()
        }

    }

}
