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

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        view.isUserInteractionEnabled = false

        viewModel.register(email: email, username: username, password: password)
        {
            [weak self] result in
            guard let self = self else { return }

            // Remove spinner and re-enable interaction
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.view.isUserInteractionEnabled = true

            switch result {
            case .success:
                // Navigate to Home only after a successful signup
                self.flowDelegate?.goToHomeView()
            case .failure(let error):

                if let validation = error as? ValidationWrapper {
                    applyValidationErrors(validation.errors)
                    return
                }

                func applyValidationErrors(_ errors: [ValidationError]) {

                    // Primeiro limpar UI
                    contentView.clearAllErrors()

                    for error in errors {
                        switch error {
                        case .emptyUsername:
                            contentView.nameField.showError("Nome obrigatório")
                        case .weakPassword:
                            contentView.passwordField.showError(
                                "Password demasiado curta"
                            )
                        case .invalidEmail:
                            contentView.emailField.showError("Email inválido")
                        }
                    }
                }
                
               

                let nsError = error as NSError

                print("ERRO ORIGINAL:", error)
                print("DOMAIN:", nsError.domain)
                print("CODE:", nsError.code)
                print("USER INFO:", nsError.userInfo)

                var message = "Ocorreu um erro desconhecido."

                // 1. Erros do teu ViewModel
                if let myError = error as? MyError {
                    switch myError {
                    case .invalidInput: message = "Campos inválidos."
                    case .keychainError:
                        message = "Erro ao gravar a password no Keychain."
                    }
                }
                // 2. Erros de rede
                else if nsError.domain == NSURLErrorDomain {
                    message = "Erro de rede: \(nsError.localizedDescription)"
                }
                // 3. Erros do Supabase (GoTrue)
                else if nsError.domain.contains("GoTrue")
                    || nsError.domain.contains("supabase")
                {
                    message = "Erro Supabase: \(nsError.localizedDescription)"
                }
                // 4. Outro erro qualquer
                else {
                    message = nsError.localizedDescription
                }

                let alert = UIAlertController(
                    title: "Signup Failed",
                    message: message,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}
