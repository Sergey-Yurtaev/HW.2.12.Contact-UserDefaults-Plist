//
//  StorageManager.swift
//  HW.2.12.Contact(UserDefaults)
//
//  Created by Sergey Yurtaev on 31.05.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let contactKey = "contacts"
    
    /* Plist File
    private let documentDerectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var archiveURL: URL!
    
    private init() {
        archiveURL = documentDerectory.appendingPathComponent("Contacts").appendingPathExtension("plist")
    }
    */
    
    func fetchContacts() -> [Person] {
        guard let data = userDefaults.object(forKey: contactKey) as? Data else { return [] }
        guard let contacts = try? JSONDecoder().decode([Person].self, from: data) else { return [] }
        return contacts
    }
    
    func saveContacts(with contact: Person) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefaults.set(data, forKey: contactKey)
    }
    
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefaults.set(data, forKey: contactKey)
    }
    
    /* Plist File Methods
    func fetchContactsFromFile() -> [Person] {
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let contacts = try? PropertyListDecoder().decode([Person].self, from: data) else { return [] }
        return contacts
    }
    
    func saveContactsToFile(with contact: Person) {
        var contacts = fetchContactsFromFile()
        contacts.append(contact)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
    
    func deleteContactFromFile(at index: Int) {
        var contacts = fetchContactsFromFile()
        contacts.remove(at: index)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
     */
}
