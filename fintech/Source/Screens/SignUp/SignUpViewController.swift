import Foundation
import UIKit

class SignUpViewController: UIViewController {

    let contentView: SignUpView
    let viewModel: SignUpViewModel
    weak var flowDelegate: SignUpViewFlowDelegate?

    init(
        contentView: SignUpView,
        viewModel: SignUpViewModel,
        flowDelegate: SignUpViewFlowDelegate?
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.addSubview(contentView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SignUpViewController: SignUpViewDelegate {
    func didTapSignUpButton(username: String, password: String, email: String) {
        print("Sign Up Button Tapped")
        print("Username: \(username)")
        print("Password: \(password)")
        print("Email: \(email)")

        flowDelegate?.goToHomeView()

        print("uHUHUhuh")
    }
}
