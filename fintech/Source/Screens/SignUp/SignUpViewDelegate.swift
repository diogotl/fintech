//
//  SignUpViewDelegate.swift
//  fintech
//
//  Created by Diogo on 27/07/2025.
//

protocol SignUpViewDelegate: AnyObject {
    func didTapSignUpButton(username: String, password: String, email: String)
}
