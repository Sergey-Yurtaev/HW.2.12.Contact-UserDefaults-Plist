//
//  ViewController.swift
//  HW.2.12.Contact(UserDefaults)
//
//  Created by Sergey Yurtaev on 31.05.2022.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var contacts: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = StorageManager.shared.fetchContacts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newContact = segue.destination as! NewContactViewController
        newContact.delegate = self
    }
}

// MARK: - UITAbleViewDataSource
extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellContact", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].fullName
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.shared.deleteContact(at: indexPath.row)
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

// MARK: - NewContactViewControllerDelegate
extension ContactViewController: NewContactViewControllerDelegate {
    func saveContact(_ contact: Person) {
        contacts.append(contact)
        tableView.reloadData()
    }
}
