//
//  NewContactViewController.swift
//  HW.2.12.Contact(UserDefaults)
//
//  Created by Sergey Yurtaev on 31.05.2022.
//

import UIKit

class NewContactViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    var delegate: NewContactViewControllerDelegate!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDoneEnabled()
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        saveAndExit()
    }
    
    @objc private func textFieldsDidChanged() {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        doneButton.isEnabled = !firstName.isEmpty || !lastName.isEmpty ? true : false
    }
    
    private func setupDoneEnabled() {
        firstNameTextField.addTarget(
            self,
            action: #selector(textFieldsDidChanged),
            for: .editingChanged
        )
        
        lastNameTextField.addTarget(
            self,
            action: #selector(textFieldsDidChanged),
            for: .editingChanged)
    }
    
    private func setupView() {
        doneButton.isEnabled = false
        firstNameTextField.placeholder = "First name"
        lastNameTextField.placeholder = "Last name"
        firstNameTextField.font = .systemFont(ofSize: 20)
        lastNameTextField.font = .systemFont(ofSize: 20)
    }
    
    private func saveAndExit() {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        
        let contact = Person(firstName: firstName, lastName: lastName)
        StorageManager.shared.saveContacts(with: contact)
        
        delegate.saveContact(contact)
        dismiss(animated: true)
    }
    
    deinit {
        print("NewContactViewController has been dealocated")
    }
}
