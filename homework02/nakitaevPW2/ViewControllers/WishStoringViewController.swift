//
//  WishStoringViewController.swift
//  nakitaevPW2
//
//  Created by Никита Китаев on 10.02.2024.
//

import UIKit
import CoreData

// MARK: -
final class WishStoringViewController: UIViewController {
    enum Constants {
        static let backgroundColor: UIColor = UIColor("#5E25CB")
        
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
        static let tableSideOffset: CGFloat = 20
        static let desiredRowHeight: CGFloat = 46
        
        static let numberOfSections: Int = 2
        static let sectionGap: CGFloat = 5
        
        static let wishesKey: String = "userWishes"
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [Wish] = []
    private let defaults = UserDefaults.standard
    private var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        wishArray = CoreDataManager.shared.fetchWishes()
        
        view.backgroundColor = Constants.backgroundColor
        configureTable()
        configureHidingKeyboard()
    }
    
    // MARK: Confurates table.
    private func configureTable() {
        table.dataSource = self
        
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        table.allowsSelection = true
        view.addSubview(table)
        table.pin(to: view, Constants.tableOffset)
    }

    public func addWishAction(wish: String) {
        let wishEntity = CoreDataManager.shared.createWish(Int16(wishArray.count - 1), text: wish)
        
        if wishEntity != nil {
            wishArray.append(wishEntity!)
        }
        
        table.reloadData()
    }
    
    public func deleteWishAction(id: Int16) {
        guard let index = wishArray.firstIndex(where: { $0.id == id }) else { return }
        
        if let deletedWish = CoreDataManager.shared.deleteWish(with: Int16(id)) {
            wishArray.remove(at: index)
            print("Deleted wish: \(deletedWish)")
            
            table.reloadData()
        }
    }
    
    public func editWishAction(id: Int16) {
        let alertController = UIAlertController(title: "Edit Wish", message: nil, preferredStyle: .alert)
        guard let index = wishArray.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter your wish"
            textField.text = self.wishArray[index].text
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let textField = alertController.textFields?.first {
                if let updatedWish = CoreDataManager.shared.updateWish(with: Int16(id), newText: textField.text!) {
                    self.wishArray[index] = updatedWish
                    
                    self.table.reloadData()
                }
            }
        }
        
        saveAction.isEnabled = false
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let alertController = presentedViewController as? UIAlertController,
           let saveAction = alertController.actions.last {
            saveAction.isEnabled = textField.text?.isEmpty == false
        }
    }
    
    private func configureHidingKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // Section 0: AddWishCell
            return 1
        } else {
            // Section 1: WrittenWishCell
            return wishArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Section 0: AddWishCell
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            addWishCell.configureAddWish{ [weak self] wish in
                self?.addWishAction(wish: wish)
            }
            
            return cell
        } else {
            // Section 1: WrittenWishCell
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            let wish = wishArray[indexPath.row]
            wishCell.configure(with: wish.text!)
            wishCell.id = wish.id
            
            wishCell.configureDeleteWish{ [weak self] id in
                self?.deleteWishAction(id: wish.id)
            }
            
            wishCell.configureEditWish{ [weak self] id in
                self?.editWishAction(id: wish.id)
            }
            
            return wishCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.desiredRowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
}

// MARK: - UIGestureRecognizerDelegate
extension WishStoringViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view is UIControl)
    }
}
